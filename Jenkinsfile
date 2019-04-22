node {
  stage('Checkout/Build/Test') {
	//Checkout Files
	checkout([
	  $class: 'GitSCM',
	  branches: [[name: 'watchKit']],
	  doGenerateSubmoduleConfigurations: false,
	  extensions: [], submodulCfg: [],
  	  userRemoteConfigs: [[
		name: 'github',
		url: 'https://github.com/shopon2024/task.git'
	    ]]
     ])
	// Build and Test
        sh 'bundle exec fastlane test'
	
	//Publish test results
	step([
	  $class: 'JUnitResultArchiver', 
	  allowEmptyResults: true, 
	  testResults: 'fastlane/test_output/report.junit'
	])

  }

  stage('Analytics') {
	parallel Coverage: {
	  //Generate Code Coverage Report
	  sh 'slather coverage --jenkins --cobertura --scheme Task --workspace ./Task.xcworkspace ./Task.xcodeproj'

	 publishXML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'test-reports', reportFiles: 'cobertura.xml', reportName: 'Coverage Report'])
	}
  }
}