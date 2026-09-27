import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final String _supabaseUrl = 'https://xblablbvlzuklebsfzej.supabase.co';
  static final String _supabaseKey =
      'sb_publishable_XI-igqSDD4CswfXe_VR_Ag_3O_nKXAl';

  static initil() async {
    await Supabase.initialize(url: _supabaseUrl, publishableKey: _supabaseKey);
  }
}
