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
			
			  $scope.personList=[];  
			  $scope.person={};
			  
			  
//------------------ Request to Get all Person List ---------------------------------------------------			
			$http({
	             url: "GetAllPersonList/",
	             method: "POST",          
	         })
	         .then(function(response) {
	                 // if success       	
	         	 console.log("WE got All Person List");
	                
	                 $scope.personList=response.data;
	                 console.log($scope.personList);
	         	          
	         }, 
	         function(data) { // optional
	                 // failed
	                 
	         	 console.log(" failed to get the SubjectTreeStruct");      
	         });
			
			
//------------------ delete Person Fucntion  ---------------------------------------------------			
			$scope.deletePerson=function(person)
			{
				$http({
		             url: "DeletePerson/"+person.id,
		             method: "POST",          
		         })
		         .then(function(response) {
		                 // if success       	
		         	 console.log("success Person is deleted");
		         	 
		                 //delete the person from array of personlist
		         	 for( var i=0; i<$scope.personList.length; i++)
	   			        { 
		         		 if(person.id==$scope.personList[i].id)
	   				   
	   				     $scope.personList.splice(i,1);
		        		} 
		         }, 
		         function(data) { // optional
		                 // failed
		                 
		         	 console.log(" failed to Delete Person");      
		         });
				
			};
			
			

//-------------------Function to update the Modal form with values of Person To update			
			$scope.loadUpdatePerson=function(person){
			
				// load the value of person to edit in modal
				$scope.person.id=person.id;
				$scope.Updatefname=person.fname;
				$scope.Updatemname=person.mname;
				$scope.Updatelname=person.lname		
				$scope.Updatehobby=person.hobby;

				
			};
			
			
			
//------------------ Update Person Fucntion  ---------------------------------------------------				
			$scope.UpdatePerson=function(){
				$scope.person.fname=$scope.Updatefname;
				$scope.person.mname=$scope.Updatemname;
				$scope.person.lname=$scope.Updatelname		
				$scope.person.hobby=$scope.Updatehobby;
				console.log($scope.person);
					  				   			
	   		 var data=JSON.stringify($scope.person);
	   		 console.log("for post request "+data);
	   			
	   			$http({
		             url: "UpdatePerson",
		             contentType : 'application/json; charset=utf-8',
		   	    	 dataType : 'json', 
		             method: "POST",    
		             data :data
		         })
		         .then(function(response) {
		                 // if success       	
		         	 console.log("succcess"); 
		             
		                 //delete Old Person From List
		         	 for( var i=0; i<$scope.personList.length; i++)
	   			        { 
		         		 if($scope.person.id==$scope.personList[i].id)
	   				     //delete the person from array of personlist
	   				     $scope.personList.splice(i,1);
		        		} 
		                 
		         	// add updated person to list
		         	$scope.personList.push(response.data) 
		         	$scope.person=null;
		         	$scope.person={};
 
		           		         	           
		         }, 
		         function(data) { // optional
		                 // failed		                 
		         	 console.log(" failed to save the Person");
		         console.log(data);
		         });
				
			};
			
			$scope.OpenAdd=function(person,personList){
				for(var i=0; i<personList.length;i++)
					{
					
						if(personList[i].id==person.id)
						{
							$("#add"+personList[i].id).collapse('show');
							$("#show"+personList[i].id).collapse('hide');
							
						}else{
							
							$("#add"+personList[i].id).collapse('hide');
							$("#show"+personList[i].id).collapse('hide');
						}
					}
				
			};	
			
			$scope.OpenShow=function(person,personList){				
				for(var i=0; i<personList.length;i++)
				{
				
					if(personList[i].id==person.id)
					{
						$("#add"+personList[i].id).collapse('hide');
						$("#show"+personList[i].id).collapse('show');
						
					}else{
						
						$("#add"+personList[i].id).collapse('hide');
						$("#show"+personList[i].id).collapse('hide');
					}
				}
				
			};
			
		});
</script>

</head>
<body ng-cloak class="ng-cloak">
<h1>Show person page </h1>

		<table class="table table-condensed">
		    <thead>
		      <tr>
				<th>ID</th>
				<th>First Name</th>
				<th>Father's Name</th>
				<th>SurName</th>
				<th>Hobby</th>
				<th>Update</th>
				<th>Delete</th>


			</tr>
		    </thead>
		    <tbody>
		      <tr ng-repeat="person in personList">
		        <td>{{person.id}}</td>
		        <td>{{person.fname}}</td>
		        <td>{{person.mname}}</td>
		        <td>{{person.lname}}</td>
		        <td>{{person.hobby}}</td>
		        <td><button type="button"  class="btn btn-warning" ng-click="loadUpdatePerson(person)"  data-toggle="modal" data-target="#myModal" >Update</button></td>
		        <td><button type="button" ng-click="deletePerson(person)" class="btn btn-danger">Delete</button></td>
		        
				
		      </tr>
		      
		    </tbody>
		  </table>
		    
		  
		  <!-- Modal -->
				<div id="myModal" class="modal fade" role="dialog">
					  <div class="modal-dialog">
					
					    <!-- Modal content-->
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					        <h4 class="modal-title">Update Person</h4>
					      </div>
					      <div class="modal-body">
					       
					       
					       			 <form class="form-horizontal" >
										    <div class="form-group">
										      <label class="control-label col-sm-2" for="fname">First name:</label>
										      <div class="col-sm-10">
										        <input type="text" ng-model="Updatefname" class="form-control"  id="email" placeholder="Enter First name" name="fname" required >
										      </div>
										    </div>
										    <div class="form-group">
										      <label class="control-label col-sm-2" for="mname">Middle name:</label>
										      <div class="col-sm-10">
										        <input type="text" ng-model="Updatemname" class="form-control" id="email" placeholder="Enter Middle name" name="mname" required>
										      </div>
										    </div>
										    <div class="form-group">
										      <label class="control-label col-sm-2" for="lname">Last name:</label>
										      <div class="col-sm-10">
										        <input type="text" ng-model="Updatelname" class="form-control" id="email" placeholder="Enter Last name" name="lname" required >
										      </div>
										    </div>
										    
										   
										    
										     <div class="form-group">
										      <label class="control-label col-sm-2" for="hobby">Hobby :</label>
										      <div class="col-sm-10">
										        <input type="text" ng-model="Updatehobby" class="form-control" id="email" placeholder="Enter Hobby" name="hobby" required >
										      </div>
										    </div>
										    
										    <div class="form-group">        
										      <div class="col-sm-offset-2 col-sm-10">
										        <button type="submit" ng-click="UpdatePerson()" data-dismiss="modal" class="btn btn-default">Submit</button>
										      </div>
										    </div>
										  </form>
					       
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					      </div>
					    </div>
					
					  </div>
				  </div>


</body>
</html>