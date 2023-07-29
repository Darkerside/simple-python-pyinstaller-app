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
                sh '.jenkins/scripts/install.sh'
                stash(name: 'compiled-results', includes: 'sources/*.py*')
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
        // stage('Deliver') { 
        //     agent any
        //     environment { 
        //         VOLUME = '$(pwd)/sources:/src'
        //         IMAGE = 'cdrx/pyinstaller-linux:python2'
        //     }
        //     steps {
        //         dir(path: env.BUILD_ID) { 
        //             unstash(name: 'compiled-results') 
        //             sh "docker run --rm -v ${VOLUME} ${IMAGE} 'pyinstaller -F add2vals.py'" 
        //         }
        //     }
        //     post {
        //         success {
        //             archiveArtifacts "${env.BUILD_ID}/sources/dist/add2vals" 
        //             sh "docker run --rm -v ${VOLUME} ${IMAGE} 'rm -rf build dist'"
        //         }
        //     }
        // }
        stage('Deploy') { 
            steps {
                input message: 'Yakin untuk deploy App ke production?' 
                sh './jenkins/scripts/deliver.sh'
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}
