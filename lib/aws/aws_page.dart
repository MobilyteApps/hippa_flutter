// import 'dart:convert';
// import 'dart:io';
//
// import 'package:amazon_cognito_identity_dart_2/cognito.dart';
// import 'package:async/async.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;
// import 'package:path/path.dart' as p;
//
// import 'config.dart';
// import 'policy.dart';
//
// class AwsPage {
//   Future<String> upload(File file) async {
//     String imageName = DateTime.now().millisecondsSinceEpoch.toString();
//     String imageExt = p.extension(file.path).toString();
//
//     const _awsUserPoolId = 'us-east-2_MitL8C608';
//     const _awsClientId = '14qao3ktq3gsrbas2mc8hsbpse';
//     const _region = 'us-east-2';
//     const s3Endpoint =
//         'https://securetext.s3.us-east-2.amazonaws.com/';
//     const _identityPoolId = 'us-east-2:c74bec24-9b83-481a-b53b-d4dd4a4544a1';
//
//     final _userPool = CognitoUserPool(_awsUserPoolId, _awsClientId);
//
//     final _credentials = CognitoCredentials(_identityPoolId, _userPool);
//
//     final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
//     final length = await file.length();
//
//     final uri = Uri.parse(s3Endpoint);
//     final req = http.MultipartRequest('POST', uri);
//     final multipartFile = http.MultipartFile('file', stream, length,
//         filename: path.basename(file.path));
//
//     final policy = Policy.fromS3PreSignedPost(
//         '$imageName$imageExt',
//         AWSConstants.getBucketName(),
//         15,
//         _credentials.accessKeyId!,
//         length,
//         _credentials.sessionToken!,
//         region: _region);
//
//     req.files.add(multipartFile);
//     req.fields['key'] = policy.key;
//     req.fields['acl'] = 'public-read';
//
//     print('file ${file.path}');
//
//     try {
//       final res = await req.send();
//       await for (var value in res.stream.transform(utf8.decoder)) {
//         print(value);
//       }
//       print(s3Endpoint + policy.key);
//     } catch (e) {
//       print(' catch $e');
//     }
//     return s3Endpoint + policy.key;
//   }
// }


import 'dart:convert';
import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path/path.dart' as p;

import 'config.dart';
import 'policy.dart';

class AwsPage {
  Future<String> upload(File file) async {
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    String imageExt = p.extension(file.path).toString();




        const _awsUserPoolId = 'us-east-2_MitL8C608';
    const _awsClientId = '14qao3ktq3gsrbas2mc8hsbpse';
    const _region = 'us-east-2';
    const s3Endpoint =
        'https://securetext.s3.us-east-2.amazonaws.com/';
    const _identityPoolId = 'us-east-2:c74bec24-9b83-481a-b53b-d4dd4a4544a1';


    final _userPool = CognitoUserPool(_awsUserPoolId, _awsClientId);

    final _credentials = CognitoCredentials(_identityPoolId, _userPool);

    final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    final length = await file.length();

    final uri = Uri.parse(s3Endpoint);
    final req = http.MultipartRequest('POST', uri);
    final multipartFile = http.MultipartFile('file', stream, length,
        filename: path.basename(file.path));

    final policy = Policy.fromS3PreSignedPost(
        '$imageName$imageExt',
        AWSConstants.getBucketName(),
        15,
        _credentials.accessKeyId!,
        length,
        _credentials.sessionToken!,
        region: _region);

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';

    print('file ${file.path}');

    try {
      final res = await req.send();
      await for (var value in res.stream.transform(utf8.decoder)) {
        print(value);
      }
      print(s3Endpoint + policy.key);
    } catch (e) {
      print(' catch $e');
    }
    return s3Endpoint + policy.key;
  }
}