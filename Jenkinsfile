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
	  sh 'slather coverage --scheme Task --workspace ./Task.xcworkspace ./Task.xcodeproj'

	  //Publish Coverage Report
	  cobertura coberturaReportFile: 'test-reports/cobertura.xml'
	}, Checkstyle: {
	   sh 'bundle exec fastlane lint'

	  recordIssues enabledForFailure: true, aggregatingResults: true, tool: checkStyle(pattern: 'test-reports/checkstyle-reports.xml')
	}
  }
}