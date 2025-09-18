// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
const supabaseKey = Deno.env.get("SUPABASE_API_KEY") ?? "";
const firebaseKey = Deno.env.get("FIREBASE_API_KEY") ?? "";
const firebaseUrl = "https://fcm.googleapis.com"

const supabase = createClient(supabaseUrl, supabaseKey);

Deno.serve(async (req) => {
    try{
        // Fetch user were sign in
        const{data: users, error} = await supabase
            .from("users")
            .select("*");
        if(error) throw error;

        // Fetch data from supabase
        const{data: todos, error} = await supabase
            .from("todos")
            .select("*");
            .eq("is_completed", true);
        if(error) throw error;

        // Check expired
        const now = new Date();
        const expired = todos?.filter((todo) => {
            let date: Date | null = todo?.date ? new Date(todo.date) : null;
            let time: Date | null = todo?.time ? new Date(todo.time) : null;
            if(!date || !time) return false;
            return time < now || date < now;
        });
        if(!expired || expired.length === 0){
            return new Response(
                JSON.stringify({message: "No expired todos" }),
                headers: {"Content-Type": "application/json"}
            );
        }

        // Send push notification request to FCM
        for(const todo of expired){
            await fetch(firebaseUrl + "/v1/projects/")
        }
    }
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/push' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
