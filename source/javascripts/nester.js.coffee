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
 <div class="yellow" style="padding-left:10px;">
    <div>{{node.name}}
    <p><a ng-click="showHide=!showHide">Toggle State: {{!!showHide}}</a></p>
    
  </div>

    <div ng-repeat="child in node.children">
      <tree node="child" parent="node"></tree>
         </div>
 </div>

  """
    

app.directive 'tree', ($compile) -> {

  restrict: 'E',
  scope: {
    node: "="
    parent: "="
  }

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

  $scope.root = {

    name : "root"
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

  $scope.boot = {

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


