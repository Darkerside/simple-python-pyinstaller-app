pipeline {
    agent {
        docker {
            image 'python:3.7-alpine3.17'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'python -m py_compile sources/add2vals.py sources/calc.py'
                    stash(name: 'compiled-results', includes: 'sources/*.py*')
                }
            }
        }
        stage('Test') { 
            agent {
                docker {
                    image 'qnib/pytest' 
                }
            }
            steps {
                sh 'py.test --junit-xml test-reports/results.xml sources/test_calc.py' 
            }
            post {
                always {
                    junit 'test-reports/results.xml' 
                }
            }
        }
        stage('Deliver') { 
            steps {
                input message: 'Yakin untuk deploy App ke production?'
                sh 'pip3 install pyinstaller'
                sh 'pip3 install Flask --user'
                sh 'chmod +x -R ./jenkins/scripts/deliver.sh'
                sh './jenkins/scripts/deliver.sh'
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}
