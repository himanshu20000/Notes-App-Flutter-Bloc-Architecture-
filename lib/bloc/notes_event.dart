part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class notesStarted extends NotesEvent {}

class AddNotes extends NotesEvent {
  final Notes notes;
  const AddNotes(this.notes);

  @override
  List<Object?> get props => [notes];
}

class RemoveNotes extends NotesEvent {
  final Notes notes;
  const RemoveNotes(this.notes);

  @override
  List<Object?> get props => [notes];
}

class UpdateNotes extends NotesEvent {
  final int index;
  const UpdateNotes(this.index);

  @override
  List<Object?> get props => [index];
}
