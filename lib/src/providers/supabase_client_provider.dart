import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/src/supabase_client.dart';

final subabaseClientProvider = Provider<SupabaseClient>((ref) {
  final supabaseclient = SupabaseClient(
      "https://ukcfmbxwbjllkpozsnts.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrY2ZtYnh3YmpsbGtwb3pzbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE0NDcwODgsImV4cCI6MjAxNzAyMzA4OH0.Yix4r68V-MGrd-pjwKlRA-ywcuvkJetVIOqVQ8DC2QY");
  return supabaseclient;
});