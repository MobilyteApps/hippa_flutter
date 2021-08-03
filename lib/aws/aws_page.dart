import 'dart:convert';
import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';

import 'policy.dart';

class AwsPage {
  Future<String> upload(File file) async {
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    String imageExt = p.extension(file.path).toString();

    const _awsUserPoolId = 'us-west-2_liRpKixUd';
    const _awsClientId = '44v9iemn5l4ahr7296kqfs1es8';

    const _identityPoolId = 'ap-south-1:d38e9192-fd41-4e8e-b916-7e48489857b5';
    final _userPool = CognitoUserPool(_awsUserPoolId, _awsClientId);

    final _credentials = CognitoCredentials(_identityPoolId, _userPool);
    const _region = 'ap-south-1';
    const s3Endpoint = 'https://lawyer-app.s3.ap-south-1.amazonaws.com/';

    final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    final length = await file.length();

    final uri = Uri.parse(s3Endpoint);
    final req = http.MultipartRequest("POST", uri);
    final multipartFile = http.MultipartFile('file', stream, length,
        filename: path.basename(file.path));

    final policy = Policy.fromS3PreSignedPost(
      '$imageName$imageExt',
      //AWSConstants.getBucketName(),
      "lawyer-app", 15,
      _credentials.accessKeyId!, length,
      _credentials.sessionToken!,
      region: _region,
    );

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';

    // req.fields['content-type'] = mediaType;
    //
    // req.fields['content-type'] = mediaType; //'application/pdf';
    //
    // req.fields['content-type'] = mediaType; //'application/msword';

    //req.fields['X-Amz-Credential'] = policy.credential;
    //req.fields['X-Amz-Date'] = policy.datetime;
    //req.fields['Policy'] = policy.encode();
    //req.fields['X-Amz-Signature'] = signature;
    //req.fields['x-amz-security-token'] = _credentials.sessionToken;
    print("file ${file.path}");

    try {
      final res = await req.send();
      await for (var value in res.stream.transform(utf8.decoder)) {
        print(value);
      }
      print(s3Endpoint + policy.key);
    } catch (e) {
      print(" catch $e");
    }
    return '${s3Endpoint + policy.key}';
  }
}
