Class {
	#name : #ToDoAddFormView,
	#superclass : #WAPainter,
	#instVars : [
		'toDoAddForm',
		'title',
		'categoryLabel',
		'categoryField',
		'descriptionLabel',
		'descriptionField',
		'addToDoButton',
		'contentOfCategoryField',
		'contentOfDescriptionField',
		'assignEmployeeLabel',
		'assignEmployeeSelectionButton',
		'assignEmployeeContainer'
	],
	#category : #'TODOSpike-Views'
}

{ #category : #configuring }
ToDoAddFormView >> configuringTrigger [

	addToDoButton on trigger
		serverDo: [ 
			self session applicationContext repositorySystem
				addToDoDescribedBy: contentOfDescriptionField
				categorizedBy: contentOfCategoryField
				assignedTo: (assignEmployeeSelectionButton withCurrentSelectionDo: [ :employeeName | employeeName ]).
			self session applicationContext configuringCurrentWebViewTo:
					ToDosWebView new ];
		render: self session applicationContext identifiedCurrentWebView.


	assignEmployeeSelectionButton on trigger serverDo: [ 
		assignEmployeeSelectionButton withCurrentSelectionDo: [ 
			:employeeName |  ] ]
]

{ #category : #'private - creating' }
ToDoAddFormView >> createAddToDoButton [

	addToDoButton := self componentSupplier
		                 asynchronicButtonLabeled: 'Add'
		                 applying: [ :canvas | 
			                 canvas setStyleTo: [ :button | 
				                 button
					                 height: 50 px;
					                 width: 170 px;
					                 marginLeft: 20 px;
					                 fontFamily: 'Roboto';
					                 fontWeight: #bold;
					                 fontSize: 25 px;
					                 border: 'None';
					                 borderColor: 'grey';
					                 borderWidth: 2 px;
					                 borderRadius: 10 px ] ]
]

{ #category : #'private - creating' }
ToDoAddFormView >> createAssignEmployeeContainer [

	self createAssignEmployeeLabel.
	self createAssignEmployeeSelectionButton.

	assignEmployeeContainer := ContainerWebView
		                           wrapping: [ :canvas | 
			                           canvas render: assignEmployeeLabel.
			                           canvas render:
				                           assignEmployeeSelectionButton ]
		                           intoElementBuiltUsing: [ :canvas | 
		                           canvas div ]
		                           applying: [ :theContainer | 
			                           theContainer addClass willow.
			                           theContainer setStyleTo: [ :style | 
				                           style
					                           display: 'inline-flex'] ]
]

{ #category : #'private - creating' }
ToDoAddFormView >> createAssignEmployeeLabel [

	assignEmployeeLabel := HeadingWebView
		                 displaying: 'Assigned to:'
		                 withLevel: 3
		                 applying: [ :canvas | 
			                 canvas setStyleTo: [ :style | 
				                 style
					                 color: #black;
					                 fontFamily: #Roboto;
					                 margin: 20 px;
					                 height: 20 px;
					                 marginTop: 10 px ] ]
]

{ #category : #'private - creating' }
ToDoAddFormView >> createAssignEmployeeSelectionButton [

	assignEmployeeSelectionButton := SingleSelectionWebView
		                                 dropDownListApplying: [ :dropdown | 
			                                 dropdown addClass willow.
			                                 dropdown setStyleTo: [ :style | 
				                                 style
					                                 width: 120 px;
					                                 height: 30 px;
					                                 margin: 5 px ] ]
		                                 applyingToOptions: [ :option :item | 
		                                  ].
	assignEmployeeSelectionButton allowAnyOf:
		self session applicationContext repositorySystem employeeNames
]

{ #category : #'private - creating' }
ToDoAddFormView >> createCategoryField [

	categoryField := TextFieldWebView singleLineApplying: [ :canvas | 
		                 canvas setStyleTo: [ :style | 
			                 style
				                 margin: 20 px;
				                 marginTop: 10 px;
				                 borderRadius: 10 px ] ].

	categoryField on trigger serverDo: [ 
		contentOfCategoryField := categoryField model isEmpty
			                          ifTrue: [ 
			                          Optional unusedBecause:
				                          'Unassigned Category' ]
			                          ifFalse: [ 
			                          Optional containing: categoryField model ] ]
]

{ #category : #'private - creating' }
ToDoAddFormView >> createCategoryLabel [

	categoryLabel := HeadingWebView
		  displaying: 'Category'
		  withLevel: 3
		  applying: [ :canvas | 
			  canvas setStyleTo: [ :style | 
				  style
					  color: #black;
					  fontFamily: #Roboto;
					  margin: 20 px;
					  height: 20 px;
					  marginTop: 10 px ] ]
]

{ #category : #'private - creating' }
ToDoAddFormView >> createDescriptionField [

	descriptionField := TextFieldWebView singleLineApplying: [ :canvas | 
		             canvas setStyleTo: [ :style | 
			             style
				             height: 50 px;
				             margin: 20 px;
				             marginTop: 5 px;
				             borderRadius: 10 px ] ].
		
	descriptionField on trigger serverDo: [ 
		contentOfDescriptionField := descriptionField model ].
]

{ #category : #'private - creating' }
ToDoAddFormView >> createEmployeeDescriptionLabel [

	descriptionLabel := HeadingWebView
		  displaying: 'Description'
		  withLevel: 3
		  applying: [ :canvas | 
			  canvas setStyleTo: [ :style | 
				  style
					  color: #black;
					  fontFamily: #Roboto;
					  margin: 20 px;
					  height: 20 px;
					  marginTop: 10 px ] ]
]

{ #category : #'private - creating' }
ToDoAddFormView >> createTitle [

	title := HeadingWebView
		  displaying: 'Add new ToDo'
		  withLevel: 2
		  applying: [ :canvas | 
			  canvas setStyleTo: [ :style | 
				  style
					  color: #black;
					  fontFamily: #Roboto;
					  margin: 20 px;
					  marginTop: 30 px ] ]
]

{ #category : #'private - creating' }
ToDoAddFormView >> createToDoAddFormWrapping [

	toDoAddForm := ContainerWebView
		               wrapping: [ :canvas | 
			               canvas
				               render: title;
				               render: categoryLabel;
				               render: categoryField;
				               render: descriptionLabel;
				               render: descriptionField;
				               render: assignEmployeeContainer;
				               render: addToDoButton ]
		               intoElementBuiltUsing: [ :canvas | canvas div ]
		               applying: [ :theContainer | 
			               theContainer addClass willow.
			               theContainer setStyleTo: [ :style | 
				               style
					               backgroundColor: '#	F3F3F3';
					               boxShadow:
						               '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)';
					               color: '#EE8625';
					               borderRadius: 10 px;
					               padding: 0 px;
					               display: 'inline-block';
					               height: 430 px;
					               fontSize: 20 px;
					               width: 400 px;
					               margin: 20 px ] ]
]

{ #category : #initialization }
ToDoAddFormView >> initialize [

	self createTitle.
	self createCategoryLabel.
	self createCategoryField.
	contentOfCategoryField := Optional unusedBecause:
		                          'Unassigned Category'.

	self createEmployeeDescriptionLabel.
	self createDescriptionField.
	contentOfDescriptionField := Optional unusedBecause:
		                             'The user must add a description in the form'.

	self createAssignEmployeeContainer.

	self createAddToDoButton.
	self createToDoAddFormWrapping
]

{ #category : #rendering }
ToDoAddFormView >> renderContentOn: aRenderer [

	self configuringTrigger .
	aRenderer render: toDoAddForm
]
