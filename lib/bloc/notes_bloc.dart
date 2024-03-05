// notes_bloc.dart (main file)
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/data/notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends HydratedBloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<notesStarted>(_onStarted);
    on<AddNotes>(_onAddNotes);
    on<RemoveNotes>(_onRemoveNotes);
    on<UpdateNotes>(_onUpdateNotes);
  }

  void _onStarted(notesStarted event, Emitter<NotesState> emit) {
    if (state.status == NotesStatus.success) return;
    emit(state.copyWith(notes: state.notes, status: NotesStatus.success));
  }

  void _onAddNotes(
    AddNotes event,
    Emitter<NotesState> emit
  ){
    emit(state.copyWith(status: NotesStatus.loading));
    try{
      List<Notes> temp =[];
      temp.addAll(state.notes);
      temp.insert(0,event.notes);
      emit(
        state.copyWith(
          notes: temp,
          status: NotesStatus.success
        )
      );
    }catch(e){
      emit(state.copyWith(status: NotesStatus.error));
    }
  }

  void _onRemoveNotes(
      RemoveNotes event,
      Emitter<NotesState> emit
      ){
    emit(state.copyWith(status: NotesStatus.loading));
    try{
      state.notes.remove(event.notes);
      emit(
          state.copyWith(
              notes: state.notes,
              status: NotesStatus.success
          )
      );
    }catch(e){
      emit(state.copyWith(status: NotesStatus.error));
    }
  }

  void _onUpdateNotes(
      UpdateNotes event,
      Emitter<NotesState> emit
      ){
    emit(state.copyWith(status: NotesStatus.loading));
    try{
     state.notes[event.index].isDone = !state.notes[event.index].isDone;
      emit(
          state.copyWith(
              notes: state.notes,
              status: NotesStatus.success
          )
      );
    }catch(e){
      emit(state.copyWith(status: NotesStatus.error));
    }
  }

  @override
  NotesState fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic> notesJson = json['notes'] ?? [];
      final List<Notes> notes =
      notesJson.map((noteJson) => Notes.fromJson(noteJson)).toList();
      return NotesState(notes: notes);
    } catch (e) {
      return const NotesState();
    }
  }

  @override
  Map<String, dynamic> toJson(NotesState state) {
    return {'notes': state.notes.map((note) => note.toJson()).toList()};
  }

}

// Your other code for the main file
