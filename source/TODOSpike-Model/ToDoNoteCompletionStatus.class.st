Class {
	#name : #ToDoNoteCompletionStatus,
	#superclass : #Object,
	#instVars : [
		'toDoNote'
	],
	#category : #'TODOSpike-Model'
}

{ #category : #testing }
ToDoNoteCompletionStatus class >> isAbstract [
		
	^ self == ToDoNoteCompletionStatus
]

{ #category : #'instance creation' }
ToDoNoteCompletionStatus class >> references: aTodoNote [

	self subclassResponsibility
]

{ #category : #transitioning }
ToDoNoteCompletionStatus >> assignNewCompletionDate: aCompletionDate [

	self subclassResponsibility
]

{ #category : #transitioning }
ToDoNoteCompletionStatus >> assignTo: aNameEmployee [

	self subclassResponsibility
]

{ #category : #'initialization - private' }
ToDoNoteCompletionStatus >> initializeIsStateOf: aToDoNote [

	self subclassResponsibility
]

{ #category : #testing }
ToDoNoteCompletionStatus >> isFinished [

	self subclassResponsibility
]

{ #category : #testing }
ToDoNoteCompletionStatus >> isInProgress [

	self subclassResponsibility
]

{ #category : #testing }
ToDoNoteCompletionStatus >> isOpen [

	self subclassResponsibility
]