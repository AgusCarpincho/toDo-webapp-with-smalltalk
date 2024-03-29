Class {
	#name : #ToDoView,
	#superclass : #WAPainter,
	#instVars : [
		'lookDescriptionButton',
		'toDoView',
		'toDo',
		'setCompletionStatusSelectionButton',
		'optionalDeleteToDoButton'
	],
	#category : #'TODOSpike-Views'
}

{ #category : #initialization }
ToDoView class >> with: aToDoNote [

	^ self new initializeWith: aToDoNote
]

{ #category : #configuring }
ToDoView >> configureTriggerForDeleteToDoButton [

	optionalDeleteToDoButton withContentDo: [ :optionalDeleteToDo | 
		optionalDeleteToDo on trigger
			serverDo: [ 
				self session applicationContext repositorySystem 	
					deleteToDoIdentified: toDo identifier.
				self session applicationContext configuringCurrentWebViewTo:
						ToDosWebView new ];
			render: self session applicationContext identifiedCurrentWebView ]
]

{ #category : #configuring }
ToDoView >> configureTriggerForLookDescriptionButton [

	lookDescriptionButton on trigger
		serverDo: [ 
			self session applicationContext configuringCurrentWebViewTo:
					(CompleteDescriptionOfToDoView withInformationOf: toDo) ];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #configuring }
ToDoView >> configureTriggerForSetCompletionStatusSelectionButton [

	setCompletionStatusSelectionButton on trigger
		serverDo: [ 
			setCompletionStatusSelectionButton withCurrentSelectionDo: [ 
					:completionStatus | 
					(completionStatus sameAs: 'Open') ifTrue: [ 
							self session applicationContext repositorySystem 
								modifyCompletionStatusToOpenTheToDoIdentified: toDo identifier ].
					(completionStatus sameAs: 'In Progress') ifTrue: [ 
							self session applicationContext repositorySystem 
								modifyCompletionStatusToInProgressTheToDoIdentified:
									toDo identifier ].
					(completionStatus sameAs: 'Finished') ifTrue: [ 
							self session applicationContext repositorySystem 
								modifyCompletionStatusToFinishedTheToDoIdentified:
									toDo identifier ] ].
			self session applicationContext configuringCurrentWebViewTo:
					ToDosWebView new ];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #configuring }
ToDoView >> configureTriggers [

	self configureTriggerForDeleteToDoButton.
	self configureTriggerForLookDescriptionButton.
	self configureTriggerForSetCompletionStatusSelectionButton
]

{ #category : #'private - creating' }
ToDoView >> createDeleteToDoButton [

	^ self componentSupplier
		  asynchronicButtonLabeled: 'Delete'
		  applying: [ :button | button addClass bootstrap3 buttonDanger ]
]

{ #category : #'private - creating' }
ToDoView >> createLookDescriptionButton [

	lookDescriptionButton := self componentSupplier
		  asynchronicButtonLabeled: 'info'
		  applying: [ :button | button addClass bootstrap3 buttonPrimary ]
]

{ #category : #'private - creating' }
ToDoView >> createSetCompletionStatusSelectionButton [

	setCompletionStatusSelectionButton := SingleSelectionWebView
		                                      dropDownListApplying: [ 
		                                      :dropdown | 
		                                      dropdown addClass willow ]
		                                      applyingToOptions: [ 
		                                      :option 
		                                      :item |  ].

	setCompletionStatusSelectionButton allowAnyOf:
		#( 'Open' 'In Progress' 'Finished' ).
]

{ #category : #initialization }
ToDoView >> initializeWith: aToDo [

	toDo := aToDo.
	self createLookDescriptionButton.
	self createSetCompletionStatusSelectionButton.
	
	optionalDeleteToDoButton := Optional unused.
	toDo isOpen ifTrue: [ 
		optionalDeleteToDoButton := Optional containing:
			                            self createDeleteToDoButton ].
	toDoView := ContainerWebView
		            wrapping: [ :canvas | 
			            canvas
				            render: '#' , aToDo identifier greaseString , ' ';
				            render: aToDo category greaseString , ' ';
				            render: 'Set to: ';
				            render: setCompletionStatusSelectionButton;
				            render: lookDescriptionButton.
			            optionalDeleteToDoButton withContentDo: [
				            :deleteToDoButton | canvas render: deleteToDoButton ] ]
		            intoElementBuiltUsing: [ :canvas | canvas div ]
		            applying: [ :theContainer | 
			            theContainer addClass willow.
			            theContainer setStyleTo: [ :style | 
				            style
					            backgroundColor: '#	F3F3F3';
					            boxShadow:
						            '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)';
					            color: '#black';
					            borderRadius: 10 px;
					            padding: 10 px;
					            display: 'inline-block';
					            height: 60 px;
					            fontSize: 20 px;
					            width: 450 px;
					            margin: 5 px ] ]
]

{ #category : #rendering }
ToDoView >> renderContentOn: aRenderer [

	self configureTriggers.
	aRenderer render: toDoView
]
