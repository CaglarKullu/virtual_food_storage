import 'package:supabase_flutter/supabase_flutter.dart';

const String supabaseUrl = 'https://ukcfmbxwbjllkpozsnts.supabase.co';
const String supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrY2ZtYnh3YmpsbGtwb3pzbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE0NDcwODgsImV4cCI6MjAxNzAyMzA4OH0.Yix4r68V-MGrd-pjwKlRA-ywcuvkJetVIOqVQ8DC2QY';

final SupabaseClient supabaseClient =
    SupabaseClient(supabaseUrl, supabaseAnonKey);
