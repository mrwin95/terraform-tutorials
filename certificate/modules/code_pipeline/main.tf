resource "aws_s3_bucket" "codepipleline-bucket" {
  bucket = var.codepipleline_bucket
}

# s3 role
resource "aws_iam_role" "codepipeline_role" {
  name = var.codepipleline_role_name
  assume_role_policy = jsondecode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Effect : "Allow",
        Principal = {
          Service : "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy" "codepipeline_policy" {
  name = var.codepipleline_policy
  role = aws_iam_role.codepipeline_role.id
  policy = jsondecode({
    Version : "2012-10-17",
    Statement : [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Effect : "Allow",
        Resource = [
          aws_s3_bucket.codepipleline-bucket.arn,
          "${aws_s3_bucket.codepipleline-bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "codebuild:*"
        ],
        Resource = "*"
      }
    ]
  })
}

# create code build project
resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_role_name
  assume_role_policy = jsondecode({
    Version : "",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Effect : "Allow",
        Principal = {
          Service : "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = var.codebuild_policy_name
  role = aws_iam_role.codebuild_role.id
  policy = jsondecode({
    Action = [
      "s3:*",
      "logs:*"
    ],
    Effect : "Allow",
    Resource : "*"
  })
}

resource "aws_codebuild_project" "codebuild_project" {
  name         = var.codebuild_project_name
  service_role = aws_iam_role.codebuild_role.arn
  artifacts {
    type = "NO_ATTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name  = "EXAMPLE_ENV_VAR"
      value = "EXAMPLE_ENV_VAR"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("buildspec.yml")
  }

  cache {
    modes    = ["LOCAL_SOURCE_CACHE", "LOCAL_DOCKER_LAYER_CACHE", "LOCAL_CUSTOM_CACHE"]
    location = "/cache"
  }
}

# create codepipeline

resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.id
  artifact_store {
    location = aws_s3_bucket.codepipleline-bucket.bucket
    type     = "S3"
  }

  # with bitbucket
  # stage {
  #     name = "Source"

  #     action {
  #       name             = "Bitbucket_Source"
  #       category         = "Source"
  #       owner            = "ThirdParty"
  #       provider         = "Bitbucket"
  #       version          = "1"
  #       output_artifacts = ["source_output"]

  #       configuration = {
  #         Owner      = "bitbucket_owner"
  #         Repo       = "bitbucket_repo"
  #         Branch     = "main"
  #         OAuthToken = "bitbucket_oauth_token"
  #       }
  #     }
  #   }
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        RepositoryName = ""
        BranchName     = ""
      }
    }
  }
  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = ""
      input_artifacts  = ["source_input"]
      output_artifacts = ["source_output"]
      configuration = {
        ProjectName = aws_codebuild_project.codebuild_project.name
      }
    }
  }
}

