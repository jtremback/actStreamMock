app = angular.module("myApp", [])

treeHtml =
  """
 <div class="blue" style="padding-left:10px;">
    <div>{{node.name}}
    
  </div>

    <div ng-repeat="child in node.children">
      <tree node="child" parent="node"></tree>
         </div>
 </div>

  """

kneeHtml =
  """
 <div ng-click="showHide=!showHide" class="yellow" style="padding-left:10px;">
    <div>{{node.name}}
    <p><a>Toggle State: {{!!showHide}}</a></p>
    
  </div>

    <div ng-hide="showHide" ng-repeat="child in node.children">
      <tree node="child" parent="node"></tree>
         </div>
 </div>

  """
    
# Identifies directives in html
app.directive 'tree', ($compile) -> {
# Makes sure that elements with 'tree' as the element name are used
  restrict: 'E',
# Not sure exactly what this does, has something to do with nesting
  scope: {
    node: "="
    parent: "="
  }
# Calls in correct html
  link : (scope, elem, attrs) ->
    elem.append ($compile treeHtml) scope
}



app.directive 'knee', ($compile) -> {

restrict: 'E',
scope: {
  node: "="
  parent: "="
}

link : (scope, elem, attrs) ->
  elem.append ($compile kneeHtml) scope
}




@MyCtrl = ($scope) ->

  $scope.roots = {

    name : "root"
    children : [ 
      {name : "Child 1", 
      children : [
        {name : "Grandchild 1",
        children : [] }
        ] }, 
      
      {name : "Child 2", 
      children : [] }
    ],
    name : "root2"
    children : [ 
      {name : "Child 1", 
      children : [
        {name : "Grandchild 1",
        children : [] }
        ] }, 
      
      {name : "Child 2", 
      children : [] }
    ]
  }

  $scope.foots = {

    name : "foot"
    children : [ 
      {name : "Child 1", 
      children : [
        {name : "Grandchild 1",
        children : [] }
        ] }, 
      
      {name : "Child 2", 
      children : [] }
    ]
  }

  $scope.boots = {

    name : "boot"
    children : [ 
      {name : "Child 1", 
      children : [
        {name : "Grandchild 1",
        children : [] }
        ] }, 
      
      {name : "Child 2", 
      children : [] }
    ]
  }


