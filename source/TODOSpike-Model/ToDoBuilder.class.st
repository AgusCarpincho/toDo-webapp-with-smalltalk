Class {
	#name : #ToDoBuilder,
	#superclass : #Object,
	#instVars : [
		'category',
		'description',
		'assignedEmployee',
		'completionDate',
		'identifier'
	],
	#category : #'TODOSpike-Model'
}

{ #category : #'instance creation' }
ToDoBuilder class >> withNumericalIdentifier: aNumericalIdentifier withDescription: aDescription [

	AssertionChecker
		enforce: aNumericalIdentifier isNumber
		because: 'An identifier must be numerical'
		raising: ToDoException.

	AssertionChecker
		enforce: aDescription isNumber not
		because: 'A description must be a ByteString'
		raising: ToDoException.
	^ self new
		  initializeWithNumericalIdentifier: aNumericalIdentifier
		  withDescription: aDescription
]

{ #category : #building }
ToDoBuilder >> build [

	^ ToDo
		  identifiedByANumericalIdentifier: identifier
		  described: description
		  categorized: category
		  endingOn: completionDate
		  assignedTo: assignedEmployee
]

{ #category : #configuring }
ToDoBuilder >> configuringAssignedEmployee: anAssignedEmployee [

	(anAssignedEmployee isNotNil) ifTrue: [
	assignedEmployee := Optional containing: anAssignedEmployee]
]

{ #category : #configuring }
ToDoBuilder >> configuringCategory: aCategory [

	category := Optional containing: aCategory
]

{ #category : #configuring }
ToDoBuilder >> configuringCompletionDate: aCompletionDate [

	completionDate := Optional containing: aCompletionDate
]

{ #category : #configuring }
ToDoBuilder >> configuringWithoutCompletionDate [

	completionDate := Optional unusedBecause: 'Unassigned Completion Date'
]

{ #category : #'initialization - private' }
ToDoBuilder >> initializeWithNumericalIdentifier: aNumericalIdentifier withDescription: aDescription [

	category := Optional unusedBecause: 'Unassigned Category'.
	description := aDescription.
	assignedEmployee := Optional unusedBecause: 'Unassigned Employee'.
	completionDate := Optional unusedBecause:
		                  'Unassigned Completion Date'.
	identifier := aNumericalIdentifier
]
