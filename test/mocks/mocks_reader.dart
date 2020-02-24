import 'dart:convert';
import 'dart:io';

Map<String, dynamic> getDecodedJson(String file) =>
    json.decode(mockReader((file)));

String mockReader(String file) => File('test/mocks/$file').readAsStringSync();
