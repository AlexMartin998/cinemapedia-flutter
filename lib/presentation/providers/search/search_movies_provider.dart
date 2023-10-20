import 'package:flutter_riverpod/flutter_riverpod.dart';


// si muto el state
final searchQueryProvider = StateProvider<String>((ref) => '');
