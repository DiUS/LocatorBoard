window.LocatorBoardController = ($scope, $http) ->

	$scope.angular_message = 'Visual Locator Board'
	initRGraph()

	$http.get("weighted_data.json").then (res) ->
		$scope.relationships = res.data
		console.log $scope.relationships