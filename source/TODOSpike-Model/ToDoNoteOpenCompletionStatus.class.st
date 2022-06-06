Class {
	#name : #ToDoNoteOpenCompletionStatus,
	#superclass : #ToDoNoteCompletionStatus,
	#category : #'TODOSpike-Model'
}

{ #category : #'instance creation' }
ToDoNoteOpenCompletionStatus class >> references: aToDoNote [
(aToDoNote className sameAs: 'ToDoNote') ifFalse: [ 
		ToDoNoteException signal:
			'The Completion Satus need reference a ToDoNote' ].
	^ self new initializeIsStateOf: aToDoNote
]

{ #category : #transitioning }
ToDoNoteOpenCompletionStatus >> assignNewCompletionDate: aCompletionDate [

	toDoNote throughStateAssignNewCompletionDate: aCompletionDate
]

{ #category : #transitioning }
ToDoNoteOpenCompletionStatus >> assignTo: aNameEmployee [

	toDoNote throughStateAssignTo: aNameEmployee
]

{ #category : #'initialization - private' }
ToDoNoteOpenCompletionStatus >> initializeIsStateOf: aToDoNote [

	toDoNote := aToDoNote
]

{ #category : #testing }
ToDoNoteOpenCompletionStatus >> isFinished [

	^ false
]

{ #category : #testing }
ToDoNoteOpenCompletionStatus >> isInProgress [

	^ false
]

{ #category : #testing }
ToDoNoteOpenCompletionStatus >> isOpen [

	^ true
]