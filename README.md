# terraform-s3-lock

## example

```terraform
locals {
  region = "ap-northeast-2"
}

provider "aws" {
  region = local.region
}

module "lock-state" {
  source              = "git::https://github.com/div-ops/terraform-s3-lock.git//lock"
  aws_region          = local.region
  s3_bucket_name      = "mo-illzzi-backend-state"
  dynamodb_table_name = "mo_illzzi_backend_lock"
}
```

## policy

> 개인적으로 너무 고통스러워서 중간에 그냥 dynamodb 읽기권한은 다 줘버린 듯 합니다

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeReservedCapacityOfferings",
                "dynamodb:DescribeReservedCapacity",
                "dynamodb:DescribeLimits",
                "dynamodb:ListStreams"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DeleteItem",
                "dynamodb:DescribeContributorInsights",
                "dynamodb:ListTagsOfResource",
                "s3:ListBucket",
                "dynamodb:DeleteTable",
                "dynamodb:TagResource",
                "dynamodb:PartiQLSelect",
                "dynamodb:DescribeTable",
                "dynamodb:GetItem",
                "dynamodb:DescribeContinuousBackups",
                "dynamodb:DescribeExport",
                "dynamodb:DescribeKinesisStreamingDestination",
                "dynamodb:BatchGetItem",
                "dynamodb:ConditionCheckItem",
                "dynamodb:UntagResource",
                "dynamodb:PutItem",
                "dynamodb:Scan",
                "dynamodb:Query",
                "dynamodb:DescribeStream",
                "dynamodb:DescribeTimeToLive",
                "dynamodb:CreateTable",
                "dynamodb:DescribeGlobalTableSettings",
                "dynamodb:GetShardIterator",
                "dynamodb:DescribeGlobalTable",
                "dynamodb:DescribeBackup",
                "dynamodb:GetRecords",
                "dynamodb:DescribeTableReplicaAutoScaling"
            ],
            "Resource": [
                "arn:aws:dynamodb:*:*:table/*",
                "arn:aws:s3:::*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "s3:GetLifecycleConfiguration",
                "s3:GetBucketTagging",
                "s3:PutAccelerateConfiguration",
                "s3:GetBucketLogging",
                "s3:CreateBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketPolicy",
                "s3:PutEncryptionConfiguration",
                "s3:GetEncryptionConfiguration",
                "s3:GetBucketObjectLockConfiguration",
                "s3:DeleteBucketWebsite",
                "s3:GetBucketRequestPayment",
                "s3:PutLifecycleConfiguration",
                "s3:GetObjectTagging",
                "s3:DeleteObject",
                "s3:DeleteBucket",
                "s3:PutBucketVersioning",
                "s3:PutObjectAcl",
                "s3:GetBucketWebsite",
                "s3:PutReplicationConfiguration",
                "s3:GetBucketVersioning",
                "s3:PutBucketCORS",
                "s3:GetBucketAcl",
                "s3:GetReplicationConfiguration",
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutBucketWebsite",
                "s3:PutBucketRequestPayment",
                "s3:PutBucketLogging",
                "s3:GetBucketCORS",
                "s3:PutBucketPolicy",
                "s3:PutBucketObjectLockConfiguration"
            ],
            "Resource": "arn:aws:s3:::*"
        }
    ]
}
```
