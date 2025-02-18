# SpeakUp - Complaint Management System

## Technical Delivery
### Overview
SpeakUp is a fully functional web application designed to facilitate the filing and tracking of complaints against various organizations. The application provides users with a seamless experience to report issues, view statistics, and manage their complaints.

### Features
- **User Authentication**
  - Phone Number Authentication
  - Social Login (Google, Facebook, Apple)

- **Home Screen**
  - Search Bar for organizations
  - Complaint Statistics (Total, Open, Resolved)
  - Category Navigation (Banking, Government, Telecom)

- **Category Screen**
  - Organization/Service Listing
  - Search within Category

- **Filing Complaint**
  - Complaint Form with:
    - Organization or Service Selection
    - Description field
    - Option to add image/document attachments
    - Voice Recording option
    - Privacy Settings

- **Complaint Tracking/History**
  - List of Complaints with status and date
  - Status Updates

- **Settings**
  - Language Selection
  - About Information
  - Feedback Submission
  - Logout

- **User Profile**
  - Profile Information
  - Edit Profile

- **Notifications**
  - Complaint Status Updates

## Test Cases
### User Authentication
- **Test Case 1**: Verify phone number login with valid OTP.
- **Test Case 2**: Verify phone number login with invalid OTP.
- **Test Case 3**: Verify social login with Google.
- **Test Case 4**: Verify social login with Facebook.

### Home Screen
- **Test Case 5**: Verify search functionality for organizations.
- **Test Case 6**: Verify complaint statistics display.
- **Test Case 7**: Verify navigation to category screen.

### Category Screen
- **Test Case 8**: Verify organization listing based on selected category.
- **Test Case 9**: Verify search functionality within the category.

### Filing Complaint
- **Test Case 10**: Verify complaint form submission with valid data.
- **Test Case 11**: Verify complaint form submission with missing required fields.
- **Test Case 12**: Verify attachment upload functionality.

### Complaint Tracking/History
- **Test Case 13**: Verify complaint list displays correctly.
- **Test Case 14**: Verify status updates for complaints.

### Settings
- **Test Case 15**: Verify language selection functionality.
- **Test Case 16**: Verify feedback submission.

### User Profile
- **Test Case 17**: Verify profile information display.
- **Test Case 18**: Verify profile editing functionality.

### Notifications
- **Test Case 19**: Verify notifications for complaint status updates.

## Product Requirements Document (PRD)
### Title: Complaint Management System

### Purpose
To provide a platform for users to file complaints against organizations, track their status, and view relevant statistics.

### Scope
- **Target Audience**: General public, organizations, and government bodies.
- **Platforms**: Web application accessible via modern browsers.

### Functional Requirements
1. **User Authentication**
   - Users must be able to register and log in using phone numbers or social media accounts.

2. **Complaint Filing**
   - Users must be able to select an organization, fill out a complaint form, and submit it.

3. **Complaint Tracking**
   - Users must be able to view their submitted complaints and track their status.

4. **Statistics Dashboard**
   - Users must be able to view statistics related to complaints filed.

5. **User Profile Management**
   - Users must be able to view and edit their profile information.

6. **Settings**
   - Users must be able to change language settings and provide feedback.

### Non-Functional Requirements
- **Performance**: The application should load within 3 seconds.
- **Security**: User data must be encrypted and secure.
- **Usability**: The application should be user-friendly and accessible.

### Milestones
1. **Phase 1**: User Authentication
2. **Phase 2**: Complaint Filing and Tracking
3. **Phase 3**: Statistics Dashboard
4. **Phase 4**: User Profile and Settings

## Getting Started
To run the application locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/speakup.git
   cd speakup
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

## Deployment
To deploy the application to GitHub Pages, follow these steps:

1. Build the web application:
   ```bash
   flutter build web
   ```

2. Create a new branch for deployment:
   ```bash
   git checkout -b gh-pages
   ```

3. Copy the contents of the `build/web` directory to the root of your `gh-pages` branch:
   ```bash
   cp -r build/web/* .
   ```

4. Commit and push the changes:
   ```bash
   git add .
   git commit -m "Deploy to GitHub Pages"
   git push origin gh-pages
   ```

5. Configure GitHub Pages in your repository settings.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
