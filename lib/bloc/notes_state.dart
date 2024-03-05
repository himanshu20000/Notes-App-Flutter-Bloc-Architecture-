part of 'notes_bloc.dart';

enum NotesStatus { initial, loading, error, success }

class NotesState extends Equatable {
  final List<Notes> notes;
  final NotesStatus status;

  const NotesState({
    this.notes = const <Notes>[],
    this.status = NotesStatus.initial,
  });

  NotesState copyWith({
    List<Notes>? notes,
    NotesStatus? status,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  @override
  factory NotesState.fromJson(Map<String, dynamic> json) {
    try {
      var listofNotes = (json['notes'] as List<dynamic>)
          .map((e) => Notes.fromJson(e as Map<String, dynamic>))
          .toList();
      return NotesState(
          notes: listofNotes,
          status: NotesStatus.values.firstWhere(
              (element) => element.name.toString() == json['status']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'notes': notes,
      'status': status.name,
    };
  }

  @override
  List<Object?> get props => [notes, status];
}
