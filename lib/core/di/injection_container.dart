import 'package:aqar_hub_gp/features/authentication/domain/repositories/auth_repository.dart';
import 'package:aqar_hub_gp/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:aqar_hub_gp/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:aqar_hub_gp/features/authentication/domain/usecases/complete_profile_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/domain/usecases/send_password_reset_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/domain/usecases/sign_up_with_email_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/domain/usecases/update_user_role_usecase.dart';
import 'package:aqar_hub_gp/features/authentication/presentation/cubit/auth_cubit.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // ============================================
  // External Dependencies (Firebase, Google)
  // ============================================
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseStorage.instance);
  getIt.registerLazySingleton(() => GoogleSignIn());

  // ============================================
  // AUTHENTICATION FEATURE
  // ============================================

  // Data source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: getIt(),
      firestore: getIt(),
      googleSignIn: getIt(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => SignInWithEmailUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpWithEmailUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInWithGoogleUseCase(getIt()));
  getIt.registerLazySingleton(() => SendPasswordResetUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateUserRoleUseCase(getIt()));
  getIt.registerLazySingleton(() => CompleteProfileUseCase(getIt()));

  // Cubit
  getIt.registerFactory(
    () => AuthCubit(
      signInWithEmailUseCase: getIt(),
      signUpWithEmailUseCase: getIt(),
      signInWithGoogleUseCase: getIt(),
      sendPasswordResetUseCase: getIt(),
      updateUserRoleUseCase: getIt(),
      completeProfileUseCase: getIt(),
    ),
  );

  // // ============================================
  // // OWNER FEATURE
  // // ============================================

  // // Data source
  // getIt.registerLazySingleton<ApartmentRemoteDataSource>(
  //   () => ApartmentRemoteDataSourceImpl(firestore: getIt(), storage: getIt()),
  // );

  // // Repository
  // getIt.registerLazySingleton<ApartmentRepository>(
  //   () => ApartmentRepositoryImpl(remoteDataSource: getIt()),
  // );

  // // Use cases
  // getIt.registerLazySingleton(() => AddApartmentUseCase(getIt()));
  // getIt.registerLazySingleton(() => GetOwnerApartmentsUseCase(getIt()));
  // getIt.registerLazySingleton(() => UpdateApartmentUseCase(getIt()));
  // getIt.registerLazySingleton(() => DeleteApartmentUseCase(getIt()));

  // // Cubit
  // getIt.registerFactory(
  //   () => ApartmentCubit(
  //     addApartmentUseCase: getIt(),
  //     getOwnerApartmentsUseCase: getIt(),
  //     updateApartmentUseCase: getIt(),
  //     deleteApartmentUseCase: getIt(),
  //   ),
  // );
}
