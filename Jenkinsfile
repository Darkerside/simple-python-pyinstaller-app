pipeline {
    agent none
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:3.7-alpine3.17'
                }
            }
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
                    image 'python:3.7-alpine3.17'
                }
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'pip3 install pytest'
                    sh 'python -m pytest --junit-xml test-reports/results.xml sources/test_calc.py' 
                    sh 'python -m pytest sources/test_api.py' 
                }
            }
            post {
                always {
                    junit 'test-reports/results.xml' 
                }
            }
        }
        stage('Deliver') {
            agent any
            environment { 
                VOLUME = '$(pwd)/sources:/src'
                IMAGE = 'cdrx/pyinstaller-linux:python2'
            }
            steps {
                dir(path: env.BUILD_ID) { 
                    unstash(name: 'compiled-results') 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'pyinstaller -F add2vals.py'" 
                }
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    input message: 'Yakin untuk deploy App ke production?'
                    sh 'pip3 install Flask --user'
                    sh 'chmod +x -R ./jenkins/scripts/deliver.sh'
                    sh 'chmod +x -R ./jenkins/scripts/kill.sh'
                    sh './jenkins/scripts/deliver.sh'
                    sh './jenkins/scripts/kill.sh' 
                }
            }
            post {
                success {
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'rm -rf build dist'"
                }
            }
        }
        // stage('Deliver') { 
        //     steps {
        //         withEnv(["HOME=${env.WORKSPACE}"]) {
        //             input message: 'Yakin untuk deploy App ke production?'
        //             sh 'pip3 install pyinstaller'
        //             sh 'pip3 install Flask --user'
        //             sh 'apk add --no-cache binutils'
        //             sh 'chmod +x -R ./jenkins/scripts/deliver.sh'
        //             sh 'chmod +x -R ./jenkins/scripts/kill.sh'
        //             sh './jenkins/scripts/deliver.sh'
        //             sh './jenkins/scripts/kill.sh' 
        //         }
        //     }
        // }
        // stage('Deploy') { 
        //     steps {
        //         withEnv(["HOME=${env.WORKSPACE}"]) {
        //             input message: 'Yakin untuk deploy App ke production?'
        //             sh 'chmod +x -R ./jenkins/scripts/deploy.sh'
        //             sh './jenkins/scripts/deploy.sh' 
        //         }
        //     }
        // }
    }
}
