# Google Play submission

What to enter in Play Console for **Mulearn (`org.mulearn.app`)**, MuLearn Foundation
organisation account. It matches the App Store answers (App Privacy labels,
age rating, review notes), so the two stores say the same thing.

Items marked **[confirm]** are facts only the foundation knows; check them before
you submit. Play compares these answers with the app's real behaviour, and a
mismatch is the most common reason for rejection.

## 1. Data safety

**Does the app collect or share user data?** Yes, it collects. It shares none
with third parties (job applications don't go through the app; no analytics or ad
SDKs). Transfers to service providers that process data for you, such as crash
reporting, are not "sharing".

**Security practices**

| Question | Answer |
|---|---|
| Is data encrypted in transit? | Yes (HTTPS to `mulearn.org`) |
| Can users request data deletion? | Yes |
| Deletion request link | `https://mulearn.org/delete-account` (page text in section 2) |
| Independent security review | No |
| Committed to the Play Families Policy | No (target age 13+) |

**Data types collected** (every type is collected, processed on our servers, not
shared, and not ephemeral):

| Google category | Data type | Required or optional | Purposes |
|---|---|---|---|
| Personal info | Name | Required | App functionality, Account management |
| Personal info | Email address | Required | App functionality, Account management |
| Personal info | User IDs (μID) | Required | App functionality, Account management |
| Personal info | Phone number | **[confirm]** optional or required | App functionality, Account management |
| Personal info | Other info (date of birth, gender, college, social handles) | **[confirm]** optional or required | App functionality |
| Photos and videos | Photos (profile and cover photo) | Optional | App functionality |
| App activity | Other user-generated content (projects, comments, task submissions) | Optional | App functionality |
| App info and performance | Crash logs | Required, **not linked to the user** | App functionality |

**Not collected:** precise or approximate location, contacts, financial info, health
and fitness, messages, audio, files, calendar, web browsing history, search
history, device or other IDs, app interactions, advertising data.

**Sign-in:** Google and Apple sign-in pass an email and name to our backend, which is
already covered by the rows above.

## 2. Account deletion page (`https://mulearn.org/delete-account`)

Google needs a public page, reachable without signing in, that says which app it is
for and how to request deletion. Text to publish:

> # Delete your μLearn account
>
> This page is for the **μLearn** app (Google Play: `org.mulearn.app`), run by
> MuLearn Foundation.
>
> ## How to ask us to delete your account
>
> **In the app:** open Profile, then Settings, then **Delete account**, type DELETE
> and tap **Request deletion**. This opens an email to our team with your μLearn ID
> filled in.
>
> **By email, if you can't use the app:** write to **info@mulearn.org** with the
> subject "Account deletion request" and tell us the email address or μLearn ID of
> the account.
>
> ## What happens next
>
> 1. We reply to confirm the request comes from you.
> 2. We delete your account within **[confirm: 30] days** of confirming.
>
> ## What is deleted
>
> Your profile (name, email, phone number, date of birth, gender, college, photos and
> links), your projects and comments, your task submissions, and your karma and
> learning history.
>
> ## What we may keep
>
> **[confirm]** Records we must keep by law, and backups, which are removed on the
> normal backup schedule.
>
> Deletion is permanent and can't be undone.
>
> Questions: info@mulearn.org

## 3. Other App content declarations

| Section | Answer |
|---|---|
| Privacy policy | `https://mulearn.org/privacy-policy` |
| App access | Restricted. Provide a test account for the **production** server (email and password) in Play's instructions field. Don't put the password anywhere else. |
| Ads | No ads |
| Content rating (IARC) | Category: Education / reference. User-generated content: **yes**, with report and block. No violence, sexual content, drugs, gambling, or profanity of our own. No location sharing, no unrestricted web access. Expect roughly 12+ or Teen. |
| Target audience | 13 and over; not designed for children |
| News app | No |
| Government app | No |
| Financial features | None |
| Health apps | None |
| Advertising ID | Not used |
| User-generated content | Moderation: report (flag button, opens an email to `info@mulearn.org`), block (hides a person's content on the device), Terms agreement at sign-up. Support responds within **[confirm: 24 hours]**. |

## 4. Account-level items

- **Trader status:** a trader or non-trader declaration is required for every
  developer account by **1 February 2027** (Settings, Account details, About you). A
  not-for-profit offering a free app normally declares non-trader; **[confirm]**
  with whoever handles the foundation's legal affairs. A false declaration can
  remove the app.
- **Developer verification:** the package name `org.mulearn.app` has to be
  registered in Play Console for Android developer verification.
- **Catalog access:** under Settings, Catalog settings, opt out of third-party store
  listing if you don't want other stores to list the app.

## 5. Release checklist

1. PR merged into `dev`, then promoted to `staging` and `master` (see
   [CI-CD.md](CI-CD.md)).
2. Tag `v1.0.0`; CI builds the signed production AAB. Approve the `Production`
   deployment when the run asks.
3. Check the AAB: package `org.mulearn.app`, version name `1.0.0` (not `-dev`),
   prod flavor (talks to `mulearn.org`), target SDK 36.
4. Upload it as a **production** release (not the Alpha track). Release notes in
   plain language, for example "First release of the μLearn app."
5. Enter the answers above, then send the changes for review.
