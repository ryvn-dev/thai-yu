import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/env/env.dart';
import 'data/models/thai_glosses.dart';

Future<void> bootstrap(ProviderContainer container) async {
  await ThaiGlosses.init();

  if (Env.supabaseUrl.isNotEmpty) {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
    );
  }
}
