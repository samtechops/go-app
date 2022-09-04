
output "aws_ecr_repository_registry_id" {
  value = aws_ecr_repository.ecr.registry_id
}

output "aws_ecr_repository_repository_url" {
  value = aws_ecr_repository.ecr.repository_url
}

output "aws_ecr_repository_name" {
  value = aws_ecr_repository.ecr.name
}

output "aws_ecr_repository_arn" {
  value = aws_ecr_repository.ecr.arn
}
