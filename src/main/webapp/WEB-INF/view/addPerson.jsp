<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="myApp" ng-controller="personCtrl">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Show Person</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>

<script>
		var app = angular.module('myApp', []);
		app.controller('personCtrl', function($scope, $http) {
			
			$scope.person={};
			
		$scope.savePerson=function(){
			
			
			$scope.person.fname=$scope.fname;
			$scope.person.mname=$scope.mname;
			$scope.person.lname=$scope.lname		
			$scope.person.hobby=$scope.hobby;
			console.log($scope.person);
			
   			
   			
   			
   		 var data=JSON.stringify($scope.person);
   		 console.log("for post request "+data);
   			
   			$http({
	             url: "SavePerson",
	             contentType : 'application/json; charset=utf-8',
	   	    	 dataType : 'json', 
	             method: "POST",    
	             data :data
	         })
	         .then(function(response) {
	                 // if success       	
	         	 console.log("succcess"); 
	                 console.log("Person Saved");	
	                 $scope.person=null;
	                 $scope.fname=null;
	     			$scope.mname=null;
	     			$scope.lname=null;		
	     			$scope.hobby=null;
	                 
	           		         	           
	         }, 
	         function(data) { // optional
	                 // failed		                 
	         	 console.log(" failed to save the Person");
	         console.log(data);
	         });
			
			
			};	
		  
		});
</script>

</head>
<body ng-cloak class="ng-cloak">


			
		<div class="container">
		  <h2>Add Person form</h2>
		  <form class="form-horizontal" name="AddPersonForm">
		    <div class="form-group">
		      <label class="control-label col-sm-2" for="fname">First name:</label>
		      <div class="col-sm-10">
		        <input type="text" ng-model="fname" class="form-control"  id="email" placeholder="Enter First name" name="fname" required >
		      </div>
		    </div>
		    <div class="form-group">
		      <label class="control-label col-sm-2" for="mname">Middle name:</label>
		      <div class="col-sm-10">
		        <input type="text" ng-model="mname" class="form-control" id="email" placeholder="Enter Middle name" name="mname" required>
		      </div>
		    </div>
		    <div class="form-group">
		      <label class="control-label col-sm-2" for="lname">Last name:</label>
		      <div class="col-sm-10">
		        <input type="text" ng-model="lname" class="form-control" id="email" placeholder="Enter Last name" name="lname" required >
		      </div>
		    </div>
		    
		   
		    
		     <div class="form-group">
		      <label class="control-label col-sm-2" for="hobby">Hobby :</label>
		      <div class="col-sm-10">
		        <input type="text" ng-model="hobby" class="form-control" id="email" placeholder="Enter Hobby" name="hobby" required >
		      </div>
		    </div>
		    
		    <div class="form-group">        
		      <div class="col-sm-offset-2 col-sm-10">
		        <button type="submit" ng-click="AddPersonForm.$valid && savePerson()" class="btn btn-default">Submit</button>
		      </div>
		    </div>
		  </form>
		</div>
	


</body>
</html>