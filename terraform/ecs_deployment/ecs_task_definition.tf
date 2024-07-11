resource "aws_ecs_task_definition" "flask_task" {
  # Task Definition for the regular flask container deployment
  family = "flask_from_jenkins"
  # operatingSystemFamily required when using Fargate
  runtime_platform = {"operatingSystemFamily": "LINUX"}
  # awsvpc is the only option for Fargate
  network_mode = "awsvpc"
  containerDefinitions  [
    {
      "name": "flask_container"
      # TODO - create vars for all
      # image - that's the form we use when running containers using
      # the docker command
      "image": ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${REPO}
      

}
  
