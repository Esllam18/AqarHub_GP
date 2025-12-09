// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// final sl = GetIt.instance;

// Future<void> initializeDependencies() async {
//   // Firebase Instances
//   sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
//   sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
//   sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

//   // Data Sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(
//       firebaseAuth: sl(),
//       firestore: sl(),
//       googleSignIn: sl(),
//     ),
//   );

//   // Repositories
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(remoteDataSource: sl()),
//   );

//   // Use Cases
//   sl.registerLazySingleton(() => VerifyPhoneUseCase(sl()));
//   sl.registerLazySingleton(() => SignInWithPhoneUseCase(sl()));
//   sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
//   sl.registerLazySingleton(() => UpdateUserRoleUseCase(sl()));
//   sl.registerLazySingleton(() => CompleteProfileUseCase(sl()));

//   // Cubits
//   sl.registerFactory(
//     () => AuthCubit(
//       verifyPhoneUseCase: sl(),
//       signInWithPhoneUseCase: sl(),
//       signInWithGoogleUseCase: sl(),
//       updateUserRoleUseCase: sl(),
//       completeProfileUseCase: sl(),
//     ),
//   );
// }
