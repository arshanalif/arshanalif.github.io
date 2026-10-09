SK. ARSHAN ALIF — OWNER-CONTROLLED PORTFOLIO
============================================

FILES
- index.html: public portfolio. Visitors can only view.
- admin.html: private editing dashboard. Use your own Supabase login.
- supabase_setup.sql: database + access rules.
- README_BN.txt: these instructions in Bangla.

IMPORTANT
This package is a ready-to-configure starter website. Owner-only editing becomes secure
after you configure Supabase as described below. Do not publish admin passwords or a
Supabase service-role key. Only use the public anon/publishable key in these HTML files.

SETUP (first time)
1. Open https://supabase.com and create your own project.
2. In Project Settings > API, copy the Project URL and anon/public key.
3. Open SQL Editor in Supabase. Open supabase_setup.sql and copy its content there.
4. Before running the SQL, create your owner account:
   - Go to Authentication > Users and add your own email/password.
   - Copy the user's UUID.
   - In supabase_setup.sql, replace BOTH occurrences of YOUR_ADMIN_AUTH_USER_UUID
     with your UUID. Then run the SQL.
   - If you already ran the SQL before replacing the placeholder, edit the two policies
     by rerunning the updated SQL after replacing the UUID.
5. In admin.html, enter the Project URL and anon/public key and press Connect.
6. Log in with the email/password you created in Supabase.
7. Edit your details, skills, projects, links and profile photo. Press Save changes.
8. Publish index.html and admin.html to a static host (e.g. GitHub Pages or Netlify).
   Keep admin.html URL private as an extra precaution, but security is enforced by Supabase
   authentication + database/storage policies, not by hiding the URL.
9. For the public website to load your saved changes, replace YOUR_SUPABASE_PROJECT_URL
   and YOUR_SUPABASE_ANON_KEY in index.html with your project URL and anon/public key.
   These are public client settings. Never use the service-role key.

HOW TO USE AFTER SETUP
- Visitors open index.html and can view the site; there is no editing UI on the public page.
- Only the Supabase owner user UUID allowed in the SQL policies can write portfolio content
  or upload profile photos.
- Visit admin.html, log in, edit, and save.
- Public viewers reload the website to see updates.

SECURITY NOTES
- Use a strong unique password and enable MFA in Supabase if available.
- Do not add other user accounts if you want to remain the only editor.
- Anyone can view public portfolio text and profile photo; that is the intended public site.
- If you later want to change who can edit, update the UUID in the RLS policies.
- Before deploying, replace placeholder GitHub/LinkedIn/email and verify all content.
