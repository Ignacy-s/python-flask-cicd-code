/* From How to Use Jenkins to Build and Run an Image Using docker */


pipeline {
    agent any
    stages {
        stage("build") {
            steps {
                sh """
docker build -t ignacys/python-flask-hello .
"""
            }
        }
    }
}

