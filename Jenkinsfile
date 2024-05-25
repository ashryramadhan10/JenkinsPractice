pipeline {
    agent {
        node {
            label "jenkins_agent1"
        }
    }
    stages {
        stage("Build") {
            steps {
                echo "Build Stage, Sleep for 5 seconds"
                sleep(5)
                sh 'echo $HOME'

                echo "Start Looping:"
                script {
                    for (int i = 0; i <10; i++) {
                        echo "Script ${i}"
                    }
                }

                script {
                    def data = [
                        "firstName": "Ashry",
                        "lastName": "Ramadhan"
                    ]
                    writeJSON(file: "data.json", json: data)
                }
            }
        }
        stage("Test") {
            steps {
                echo "Test Stage"
            }
        }
        stage("Deploy") {
            steps {
                echo "Deploy Stage"
            }
        }
    }

    post {
        always {
            echo "always be executed"
        }
        changed {
            echo "condition changed will be executed"
        }
        fixed {
            echo "will be executed if error resolve"
        }
        regression {
            echo "will be executed if from success to error"
        }
        aborted {
            echo "will be executed if the pipeline is aborted manually"
        }
        failure {
            echo "if status pipeline error"
        }
        success {
            echo "if status pipeline success"
        }
        cleanup {
            echo "always be executed after previous post"
        }
    }
}