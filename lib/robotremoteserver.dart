/// Support for doing something awesome.
///
/// More dartdocs go here.
library robotremoteserver;
import 'dart:mirrors';

import 'package:xml_rpc/client.dart';
import 'package:xml_rpc/simple_server.dart' as xml_rpc_server;
import 'src/converter.dart';

// TODO: Export any libraries intended for clients of this package.

class RobotRemoteServer {
  late RemoteLibraryFactory _libraryFactory;
  late xml_rpc_server.SimpleXmlRpcServer _server;
  late RobotRemoteHandler robotRemoteHandler;

  var port;
  var host;
  var library;

  RobotRemoteServer(this.library, {this.host = '127.0.0.1', this.port = 8270}) {
    this._libraryFactory = RemoteLibraryFactory(library);
    this.robotRemoteHandler = RobotRemoteHandler(robotCodecs);
    this._register_functions();
  }

  void _register_functions() {
    this.robotRemoteHandler.add_methods(this._libraryFactory);
    this._server = xml_rpc_server.SimpleXmlRpcServer(
        host: host, port: port, handler: robotRemoteHandler);
  }

  void serve() {
    _server.start();
  }
}

class RobotRemoteHandler extends xml_rpc_server.XmlRpcHandler {
  RobotRemoteHandler(robotCodecs) : super(methods: {}, codecs: robotCodecs);

  void add_methods(RemoteLibraryFactory libraryFactory) {
    methods['get_library_information'] = libraryFactory.get_library_information;
    methods['run_keyword'] = libraryFactory.run_keyword;
  }
}

class RemoteLibraryFactory {
  Object library;

  RemoteLibraryFactory(this.library);

  get_library_information() {
    const PythonTypeMap = {
      "String": "str",
      "int": "int",
      "DateTime": "datetime"
    };
    InstanceMirror instance_mirror = reflect(library);
    var class_mirror = instance_mirror.type;
    // instance_mirror.invoke(memberName, positionalArguments)
    Map library_information = {
      '__intro__': {'doc': 'Library documentation'},
    };
    print(library_information is! Map<String, Object?>);
    for (var v in class_mirror.declarations.values) {
      if (v is MethodMirror) {
        var props = {
          'args': [],
          'types': [],
          'doc': '',
        };
        var args = [];
        var types = [];
        var name = MirrorSystem.getName(v.simpleName);
        for (var p in v.parameters) {
          var name = MirrorSystem.getName(p.simpleName);
          var type = MirrorSystem.getName(p.type.simpleName);
          args.add(name);
          types.add(PythonTypeMap[type]);
        }
        props['args'] = args;
        props['types'] = types;
        library_information[name] = props;
      }
    }
    print('returned library info $library_information');
    return library_information;
  }

  Map run_keyword(name, List args) {
    print('invoking method $name with args $args');
    var resp = {'status': 'PASS', 'output': '', 'return': ''};
    InstanceMirror instance_mirror = reflect(library);
    var ret = instance_mirror.invoke(Symbol(name), args);
    print("run keyword returned $ret");
    resp["return"] = ret.reflectee.toString();
    return resp;
  }
}
