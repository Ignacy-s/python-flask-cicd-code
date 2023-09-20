# From How to Use Jenkins to Build and Run an Image Using docker

pipeline {
    agent { label "linux" }
    stages {
        stage("build") {
            steps {
                sh """
docker build -t ignacys/python-flask-hello .
"""
            }
        }
        stage ("run") {
            steps {
                sh """
docker run --rm ignacys/python-flask-hello
"""
            }
        }
    }
}
