import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/bloc/auth/auth_state.dart';
import 'package:myproject/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState>{
    AuthCubit():super(AuthInitial());

    Future<void> login(String email, String pass) async{
        emit(AuthLoading());
        try{
            User? user = await FirebaseAuthService.instance.login(email, pass);
            emit(AuthSuccess(user: user));
        } on FirebaseAuthException catch(e){
            emit(AuthFailure(e.message ?? 'Failed to sign in'));
        }
    }
    Future<void> register (String email, String pass) async{
        emit(AuthLoading());
        try{
            User? user = await FirebaseAuthService.instance.register(email, pass);
            emit(AuthSuccess(user: user));
        } on FirebaseAuthException catch(e){
            emit(AuthFailure(e.message ?? 'Failed to register'));
        }
    }

    Future<void> SignOut() async{
        emit(AuthLoading());
        try{
            await FirebaseAuthService.instance.signOut();
            emit(AuthLoggedOut());
        } on FirebaseAuthException catch(e){
            emit(AuthFailure(e.message ?? 'Failed to sign in'));
        }
    }
}