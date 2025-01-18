# Abstract
This is a project developing an all-inclusive job search application, using Flutter and Firebase to build a cross-platform solution accessible on iOS, Android, web, and other platforms. It specifically looks to cater to the different needs of job seekers with disabilities. It features an intuitive interface, voice-to-text capability, color changes, and an option for employers to specify accessibility measures. The software is also directed to follow accessibility standards such as WCAG and compliance with the ADA. The final deliverables of this project will be a final report, application files, implementations for accessibility, and testing. This project aims to improve job accessibility so that many more people may gain access to work opportunities.

# Introduction

Job hunting has never been harder than it is today in this digital world. It becomes even more daunting when one has a disability, and most of these job search platforms are not designed with specific needs for this particular community in mind. With this in mind, I am developing a new application that will cater to making this experience more approachable for this community. This application will be accessed from either the iOS, Android, or web platforms by using Flutter and Firebase. 

The app is built for either ease of job search by job seekers or posting of jobs by employers, through an intuitive interface with personalized features. They can quickly indicate what accessibility features they have, such as 'Accessible Facilities' and 'Accommodations Provided,' and can clearly describe the nature of the requirements for a specific job and the company's culture. This altogether promotes transparency and an inclusive culture within the workplace right from the very beginning. For job seekers, the application provides opportunities to detail their special accessibility needs and job preferences. Features such as color customizations and voice-to-text will make the app accessible to people with a variety of disabilities, allowing them to flow through and easily use the application. 
The project is but one small step in this larger task of designing a world in which any person can find and get meaningful work. In focusing on the needs of one disabled person at a time, this application hopes to open doors to new job opportunities and initiate a much wider dialogue on inclusivity and accessibility in the workplace.

# Project Planning 

## Methodology Paradigm
The main reasons for using the Agile methodologies for this project were to see which would be correct in following my workflow and keeping the same under review on a regular basis. Considered methodologies in this project are Scrum, Scrumban, Agile Hybrid methods, and Kanban.
 
Scrum is an Agile framework used for work organization in sprints of one to four weeks, with a clear definition of roles and regular sessions for planning, review, and retrospectives. This framework supports a disciplined workflow in which progress and obstacles are assessed at regular intervals. In contrast, Scrum's rigid framework may sometimes limit the adaptability that one would require for a particular project. 

Scrumban integrates the structured elements of Scrum with the continuous flow approach of Kanban. It retains Scrum's roles and reviews at regular intervals while adopting the flexibility in task management that comes with Kanban. This hybrid is useful for the project that requires adaptability while maintaining a level of structured monitoring at the same time. However, the balancing of the elements of Scrum and Kanban can be complex and amount to a lot of complexity for solo project management. 

Agile Hybrid approaches provide a flexible template that can be taken by taking features from the various Agile techniques depending on the need of the project, which may include some components from the Extreme Programming methodology, Kanban, or Scrum techniques. Even though in principle this might be a very flexible approach, in practice it takes a profound knowledge base and a capability to practice multiple methodologies within the frame of a certain project when needed.

 Kanban was chosen as the most appropriate methodology to use based on the nature of project requirements and the format of my regular interaction with the supervisor. Kanban prioritizes tasks based on current capacity and maintains a continuous task flow, which fits the need for flexibility and responsiveness to change of the project. It is so, because with a Kanban board, it would be easy for the user to visually follow the progress of tasks transparently and even be able to manage the tasks without going through the formalities of sprints and sprint retrospectives. In a nutshell, the focus of Kanban on continuous improvement and the flexibility it offers regarding changing priorities and taking feedback is very apt for the effective handling of a solo project.

## Comparing cross platform development tools

The comparison then comes with the fact that both Flutter and React Native provide unique benefits for cross-platform mobile development. React Native offers high performance close to a native app through its tight native platform integration, which allows the use of native components. This native integration might be great for apps that require heavy native functionality, but it also makes everything more complicated because you will be handling all the cross-platform subtleties. However, Flutter's reliance on its drawing—through a rendering engine called Skia—for consistent drawing of UI elements on any platform guarantees not only the ideal visual appearance on all platforms but also the ease of development since there is no need to use platform-specific components for UI.

 I chose Flutter for my application due to its good design capabilities and the great experience it provides both on Android and iOS. For my app's design specifications, the ability to extensively customize and animate UI components without loss of performance was key. Second, Flutter was also more suitable due to its single codebase approach, rich pre-designed widgets, and advantages of the Dart programming language, such as ahead-of-time (AOT) compilation. These features together make the development process smooth, give good performance, and hold aesthetic consistency—key factors to make Flutter the one over React Native for me.


The following chart shows the questions asked on stack overflow about cross platform programing languages as you can see most are about flutter with react native coming in second further showing fluters popularity (Sulimau, 2024). 

![Image](https://github.com/user-attachments/assets/bac55fa6-724b-49cc-b02e-d066e72ea995)

## Comparing Backend solutions

On comparing AWS Amplify, Node.js, and Firebase as backend solutions for a Flutter project, we would come to a realization that all three offer some definite advantages and considerations. AWS Amplify is a powerhouse of services like authentication, storage, APIs, and more while being integrated with other AWS services. That makes it very scalable but complex and probably expensive. Node.js is a highly extensible and flexible environment for creating RESTful APIs and real-time features using WebSockets. It has a very huge ecosystem supported by powerful libraries and frameworks such as Express, but consequently, a little more setup, maintenance, and server management is required. In contrast, Firebase is built for super-fast development and seamless integration with Flutter, providing a real-time database, Firestore, authentication, and cloud storage. In this way, it fits perfectly for developers who want to develop and deploy applications within a short period without managing infrastructures. Keeping this in mind, Firebase is the best choice for any Flutter project that gives great balance of simplicity and powerful features with direct compatibility to Flutter, which makes development faster while saving resources.

# Plan  

## Gantt Chart 

<img width="468" alt="Image" src="https://github.com/user-attachments/assets/bc92c811-c1ea-4313-adfe-f06120444e5d" />

For my project, I use the tasks "Version" and "Test" to manage the development process. "Version" represents a new iteration of my app that I can try out and improve. Each "Test" phase is where I write tests to check for any issues in the latest version.

I track these tasks using ClickUp to create a Gantt Chart. This helps me visualize the timeline and progress of my project. In the Gantt Chart, a yellow star marks the viva meeting.

# Risk analysis 


| Num | Risk Description | Likelihood | Impact | Severity | Mitigating action |
| --- | --- | --- | --- | --- | --- |
| 1   | Breaking changes or deprecated features in new Flutter SDK or dependency updates cause app malfunctions or require significant refactoring. | Medium | High | Depending on the extent of the breaking | Regularly review and test the updates of dependencies<br><br>read the release notes for new updates in the Flutter SDK to be aware of any breaking changes |
| --- | --- | --- | --- | --- | --- |
| 2   | Issues with Firebase integration, such as data loss, security vulnerabilities, or performance bottlenecks | Low to Moderate. | High | Critical | Regularly review Firebase security rules, implement data validation mechanisms, and conduct performance optimization measures. Keep Firebase SDKs updated to mitigate security vulnerabilities. |
| --- | --- | --- | --- | --- | --- |
| 3   | Network Connectivity Issues: | Moderate | Moderate to High, | Mitigating Action | Implement offline capabilities where possible, such as caching data locally for offline access. Provide clear error messages and instructions for users during network disruptions. |
| --- | --- | --- | --- | --- | --- |
| 4   | Users may encounter data loss due to unexpected app crashes or errors during data processing. | Low to Moderate. | Moderate to High, | High | Implement data backup mechanisms, such as periodic data synchronization with Firebase Cloud Firestore or local data backups, to minimize the impact of data loss incidents. |
| --- | --- | --- | --- | --- | --- |
| 5   | Reliance on third-party services (e.g., Firebase, external APIs) introduces dependencies that may be subject to service disruptions, changes in terms of service, or discontinuation. | Moderate | High | High | Monitor the health and reliability of third-party services, maintain contingency plans for service outages or disruptions, and consider alternative service providers or in-house solutions for critical functionalities where feasible. |
| --- | --- | --- | --- | --- | --- |
| 6   | Inadequate scalability or performance issues under high user load may lead to degraded performance, slow response times, or system crashes. | Moderate | High | High | Conduct performance testing under simulated load conditions, optimize server infrastructure and database queries for scalability, and implement caching and load balancing mechanisms to distribute traffic efficiently. |
| --- | --- | --- | --- | --- | --- |


## Legal Considerations

In compliance with legal considerations, I employ Firebase Authentication to ensure the security of users' data, protecting it against unauthorized access and breaches. Additionally, I adhere to intellectual property laws by strictly avoiding the use of copyrighted material without explicit permission. This approach not only safeguards user information but also ensures that my project remains legally compliant and respectful of intellectual property rights.

## Ethical Considerations

Regarding ethical considerations, while I was supposed to test the app on users and collect data, I did not do so. Despite this, I focused on ensuring the app's positive social impact. The app is designed to improve job accessibility for disabled individuals, which can significantly enhance their employment opportunities and quality of life. In line with this, I adhered to the Web Content Accessibility Guidelines (WCAG) to make the app as accessible as possible to people with various disabilities. This adherence ensures that the app is user-friendly and inclusive, promoting equal access to job opportunities for all users. By prioritizing these aspects, I aimed to create a socially beneficial tool that aligns with ethical standards and accessibility best practices.

# Research

## **Accessibility Standards**

Before developing an app that's supposed to be used by people with disabilities, one needs to understand different accessibility standards that guide the development of any inclusive and accessible software. Such standards ensure usability for digital content and applications by anybody, despite one's physical ability. Here, we will talk about three main frameworks: the Web Content Accessibility Guidelines (WCAG), the Americans with Disabilities Act (ADA), and the European standard EN 301 549, which I won't discuss because it's similar to the WCAG.

### Web Content Accessibility Guidelines (WCAG)

WCAG, developed by the World Wide Web Consortium (W3C), is the international standard for web accessibility. It is structured around four main principles:

1. Perceivable: Information must be presented in ways that all users can perceive. This includes providing text alternatives for non-text content and ensuring that content can be presented in different ways without losing information.
2. Operable: Interface components and navigation must be usable by everyone. This involves making all functionality available from a keyboard and providing users sufficient time to read and use content.
3. Understandable: Information and the operation of the user interface must be understandable. This means making text readable and predictable, and ensuring that web pages function in predictable ways.
4. Robust: Content must be robust enough to be interpreted by a wide variety of user agents, including assistive technologies. This ensures compatibility with current and future technologies.

WCAG guidelines address specific features like color contrast, ensuring the visual presentation of text and images has a contrast ratio sufficient for users with visual impairments. Screen reader compatibility is also emphasized, ensuring that all navigation and informational text is accessible (W3C, 2018).

### Americans with Disabilities Act (ADA)

The Americans with Disabilities Act (ADA) is a crucial piece of civil rights legislation that prohibits discrimination against individuals with disabilities in all areas of public life. It aims to ensure that people with disabilities enjoy the same rights and opportunities as everyone else, encompassing employment, education, transportation, and access to public and private spaces that are open to the general public. As the digital age progresses, the ADA's scope has increasingly encompassed digital accessibility, making it a significant standard for software development(W3C, 2018).

The ADA applies to various entities, including government agencies at all levels, which are required to make their digital communications accessible. Businesses that interact with the public, such as retail stores, hotels, and dining establishments, also fall under the ADA’s purview, as do private employers with 15 or more employees, who must ensure that their work environments are accessible. Additionally, nonprofits and charities that either employ 15 or more individuals or operate for the benefit of the public are required to adhere to ADA guidelines(W3C, 2018).

While the ADA itself does not lay out specific technological standards for accessibility, it has increasingly been interpreted to suggest that digital content should comply with the Web Content Accessibility Guidelines (WCAG). This alignment with WCAG under Title III, which addresses public accommodations and commercial facilities, indicates that entities covered by the ADA should strive to meet WCAG standards to ensure their websites and other digital platforms are accessible. This interpretation helps bridge the gap between civil rights law and technological implementation, providing a clear direction for entities required to comply with the ADA on how to make their digital resources accessible to all users, including those with disabilities. This approach not only aids in compliance with the law but also fosters an inclusive atmosphere, ensuring equal access and opportunity in the increasingly digital landscape of modern society(W3C, 2018).

## User Expectations and Needs

The study, based on a survey of the RiDC's pan-disability panel which included 633 participants, reveals that while a majority of disabled individuals utilize smartphones (83%) and have installed applications (90%), approximately one in four (26%) encountered difficulties in accessing or managing these apps. Nearly half of these individuals (44%) ultimately chose to uninstall or cease using the problematic apps. This research is part of a broader investigation into home energy applications. It identifies the primary uses of apps among disabled users as communication (such as email and social networking), information (including travel and health), and administrative tasks (like utilities, banking, and travel booking). Commonly reported accessibility issues include problems with downloading and setup, navigation difficulties, lack of support for accessibility features, overcrowded displays, form completion and registration challenges, and inadequate text size or font (McCullough and Scott, 2020).

## Market research

In the UK, a significant number of disabled individuals who are not currently employed have expressed a strong need for better support in accessing and maintaining employment. According to recent government data, 56% of these individuals indicated a need for more help in finding jobs, and 60% reported needing additional assistance to keep their jobs. This highlights considerable gaps in the current support services available, which are essential for helping disabled people not only enter the job market but also sustain their employment over time(GOV.UK, 2021).

The data also sheds light on broader issues of employment inclusivity for disabled individuals. A mere 5% of disabled respondents believe that they are provided with the necessary opportunities to thrive in society, which points to a pervasive sense of inadequate employment access and support. This perception reflects a critical need for policy improvements and initiatives aimed at increasing workplace inclusivity and accessibility(GOV.UK, 2021).

Furthermore, while the focus of this analysis is primarily on disabled individuals, it is worth noting that carers also face similar challenges. A portion of carers—who balance employment with caregiving responsibilities—indicated a need for more supportive employment policies. Specifically, only 13% of carers feel that employers are adequately flexible in making workplace adjustments for those caring for disabled people. This aspect, while secondary, complements the broader narrative of the need for more inclusive and supportive employment practices across the board(GOV.UK, 2021).

## Technical Research

### The Advantages of Flutter for Cross-Platform Development

In the evolving landscape of mobile and web development, choosing the right framework is pivotal for delivering a seamless user experience across multiple platforms. Flutter, developed by Google, emerges as a powerful choice due to its unique features and capabilities. This essay explores why Flutter is favored for both mobile and web development, emphasizing its ability to maintain a consistent user interface and leverage a single codebase for Android and iOS applications(Flutter, n.d.).

### Consistent User Experience Across Platforms

Flutter's architecture allows developers to use a single codebase to deploy applications on both Android and iOS platforms. This significantly reduces the need for platform-specific code, which in turn simplifies development processes, minimizes potential bugs, and eases maintenance efforts. The single codebase approach not only streamlines the development cycle but also cuts down on costs by reducing the resources required to manage separate codebases for different operating systems(Flutter, n.d.).

### Accessibility in Mobile and Web Apps

The implementation of essential accessibility features in Flutter applications is critical for enhancing usability for a broader audience. This includes individuals with visual impairments and other disabilities. According to the Flutter documentation, these are the key approaches and technical considerations for integrating three vital accessibility features: support for large fonts, compatibility with screen readers, and sufficient contrast(Flutter, n.d.).

**Support for Large Fonts**

Flutter supports dynamic text resizing natively, enabling text within an app to adjust based on the user's device settings, which is especially beneficial for users needing larger text. Developers must ensure their UI layouts are flexible and can adapt to text size changes without losing the integrity of the user interface. Responsive design principles are essential in maintaining a coherent layout and legible text regardless of size changes. Tools like Flexible, Expanded, and LayoutBuilder widgets facilitate designing a responsive layout that adapts to user preferences for text size(Flutter, n.d.).

**Integrating Screen Readers**

Screen readers are indispensable for users with visual impairments, as they provide audio feedback that describes on-screen content, allowing navigation and interaction without visual cues. Flutter facilitates screen reader support through its integration with platform-specific technologies like TalkBack for Android and VoiceOver for iOS. The use of the Semantics widget in Flutter is crucial as it allows developers to annotate the UI with descriptions that screen readers can interpret. Ensuring that all interactive elements have meaningful labels and that navigational gestures are adequately announced by the screen reader enhances accessibility(Flutter, n.d.).

**Ensuring Sufficient Contrast**

Adequate contrast between text and its background is crucial, especially for users with visual impairments or when devices are used in varying lighting conditions. The Web Content Accessibility Guidelines (WCAG) recommend contrast ratios to ensure text is discernible. Developers need to select colors that meet or exceed these recommendations to improve readability. Automated tools like the Accessibility Scanner for Android and the Accessibility Inspector for iOS can help test and ensure that UI elements adhere to the necessary contrast levels(Flutter, n.d.).

Implementing these accessibility features according to Flutter's guidelines not only broadens the potential user base but also aligns with inclusive design principles, making applications accessible to everyone regardless of their abilities. Regular testing across different devices and using real accessibility tools is essential for validating the effectiveness of these features(Flutter, n.d.).

## Competitor Analysis

Considering the crucial role of specialized job platforms in enhancing employment opportunities for individuals with disabilities, it is paramount to highlight some of the foremost websites in this arena. I used similarweb.com to find these competitors.

1. **AbilityJobs:** Foremost, AbilityJobs presents an extensive array of functionalities, including a vast job listing and resume posting capabilities tailored specifically for individuals with disabilities. While the website is comprehensive, offering various resources, the interface's simplicity ensures that all pertinent information is readily accessible. However, the site could improve by enhancing its visual design to ensure that all users find it easy to navigate without overwhelming color schemes or layouts. Also, it does not have any accessibility features. Despite these areas for potential enhancement, AbilityJobs remains a primary choice for many due to its specialized focus and broad reach​.
2. **CareerCircle**: formerly known as Getting Hired, broadens its advocacy by focusing on diverse groups including the disabled, LGBTQ+, advancing women, BIPOC, and veterans. The platform offers both an app and a website aimed at enhancing job opportunities for these communities. In addition to providing job listings, CareerCircle also recommends and offers courses that can potentially lead to employment or further career advancement. However, despite its commendable diversity-focused initiatives, it notably lacks specific accessibility features, which are critical for the disabled demographic that it originally served. This oversight could impact the platform’s ability to fully serve all its users effectively.
3. **Careers with Disabilities**: a platform focused on empowering job seekers who face challenges related to their disabilities, also extends its resources to both employers and employees. The website features a rich array of articles and guidance designed to help employers create inclusive workplaces and assist employees in navigating their careers effectively. This wealth of information aims to foster understanding and support in the workplace, promoting opportunities for all. However, it's important to note that, despite these valuable resources, the platform currently lacks specific accessibility features on its website, and it does not offer a mobile application. This could potentially limit the accessibility for users who rely on these features to interact with online content.
4. **MyDisabilityJobs.com** is the most impressive platform I've seen thus far for job seekers with disabilities. The site's accessibility features are exceptionally user-friendly, making it straightforward for users to navigate and utilize the various services offered. Besides its core job-search functionalities, MyDisabilityJobs.com enriches the employment search experience with a wealth of resources such as insightful articles, career tips, and online courses designed to enhance professional skills and knowledge. Despite these robust offerings, it's notable that the platform does not have a mobile application, which could further enhance accessibility and convenience for users on the go. This absence may limit some users' ability to engage with the platform's resources as seamlessly as they might wish.

| **Platform** | **Strengths** | **Weaknesses** | **Findings** |
| --- | --- | --- | --- |
| AbilityJobs | Vast job listings, resume posting, and simple interface. | Needs better visual design, and lacks accessibility features. | The primary choice for many despite design and accessibility issues. |
| --- | --- | --- | --- |
| CareerCircle | Advocates for diverse groups offers courses. | Lacks specific accessibility features for the disabled. | Strong focus on diversity but needs to address accessibility. |
| --- | --- | --- | --- |
| Careers with Disabilities | Extensive resources for employers and employees, fostering workplace understanding. | No mobile app lacks specific accessibility features. | Provides valuable support, but limited by technological reach. |
| --- | --- | --- | --- |
| MyDisabilityJobs.com | User-friendly accessibility features, extensive resources, articles, and career tips. | No mobile app, limiting on-the-go access. | Exceptionally resourceful but could benefit from a mobile app. |
| --- | --- | --- | --- |

# Product Description

## Screen Flow

![Image](https://github.com/user-attachments/assets/ee7db420-fab9-4651-bda8-b5f7dcaefc49)

Creating a traditional screen flow for an app this complicated will take a lot of time and effort so I created this using Canva to showcase the main differences between guest, employee, and employer accounts

## Flow Description for Mobile Application

**Guest Account**

A guest lands on the Home Page, where they are greeted with featured jobs and a few basic filters. There is also a profile icon; clicking on it directs them to the Profile Page, which prompts them to log in. On the Home Page, guests have access to a disability button that enables features like color inversion, bold text, and inverse colors for enhanced accessibility.

Guests can navigate to the Search Page, where a list of jobs appears along with a search bar at the top and a filter button. However, upon attempting to access the Job Page, guests are informed that they need to create an account to proceed. The Profile Page is similarly restrictive, asking guests to log in before they can access any detailed profile information or features.

**Employee Account**

An employee begins by logging in through the Sign In Page using their email and password, with an option to sign up if they don't have an account. Once logged in, employees can utilize the Search Page to find jobs, using various filters and a search bar to locate positions that match their criteria.

When an employee selects a job, they are directed to the Job Selected Page, which displays the job description, company offerings, and an "Apply Now" button. Clicking this button allows the employee to apply for the job, which then appears on their Job Page under "My Jobs."

Employees can manage their profile through the Profile Page, where they have options to log out, change their password, edit their profile, and update their resume.

**Employer Account**

An employer logs in via the Sign In Page with their email and password and has the option to sign up if needed. Once logged in, employers can manage their job listings on the Job Page, which displays a list of their posted jobs. They can use the "Create Job" button to add new listings, providing necessary details such as job title, description, requirements, and salary, etc.

Each job listing shows details such as the job name, description, location, and the number of applicants. Employers can view applicants for each job and manage their job listings accordingly.

Employers also have access to their profile through the Profile Page, where they can log out, change their password, edit their profile, and update company details.

# Web 

To extend the application to a wider audience, I have configured the app for the web. It is fully responsive, utilizing layout builders and widgets to ensure adaptability across different devices. To properly host the app I need to pay for the firebase blaze plan.

To run the web version locally on your system, use the following command:

```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

## System Architecture

The architecture can be divided into two main parts: the Client-Side (frontend) and the server side (backend). Firebase acts as a Backend-as-a-Service (BaaS), simplifying many server-side operations.

**Client-Side (Frontend)**

The Flutter user interface is built using reusable widgets these widgets are reusable across platforms.

**Server-Side (Backend)**

I’ve chosen Firebase services to handle the backend of the application, providing a reliable and scalable foundation for managing various aspects of the app's functionality. Firebase offers a comprehensive suite of tools that cover essential backend requirements such as data storage, user authentication, and media asset management.

**Firebase Auth:-** firebase Authentication is a critical component of the application's backend, facilitating secure user authentication and account management. I’ve integrated Firebase Auth primarily to enable employees and employers to log in using their email and password credentials. This feature ensures that both employees and employers can access the app securely, with their authentication details encrypted and protected by Firebase's robust security measures.

When an employee or employer signs up or logs in with their email and password, Firebase Authentication handles the authentication process seamlessly, verifying the user's credentials and granting access to the app's features and content. This simplifies the user experience, eliminating the need for complex authentication logic on the client side.

In addition to user login, I’ve also implemented the functionality for users to change their passwords using Firebase Authentication. This feature allows both employee and employer to update their login credentials securely, enhancing account security and flexibility. Employees and Employers can edit password change requests through the app, and Firebase Authentication handles the process, ensuring that the new password is securely stored and encrypted.

Firebase Authentication provides a straightforward API for implementing password change functionality, streamlining the development process, and ensuring a seamless user experience.

**Firebase Firestore:**

Firebase Firestore serves as the backbone of the application's data management system, providing a powerful and scalable cloud-based database solution. I’ve leveraged Firestore extensively to store various types of data crucial for the application's functionality, including employee and employer profiles, company details, resumes, job listings, applicant lists, and more.

One of the key advantages of Firestore is its real-time data synchronization capability, which allows changes made to the database to be immediately reflected across all connected devices. This real-time synchronization ensures that users always have access to the most up-to-date information, facilitating seamless collaboration and interaction within the application.

For example, when an employer posts a new job listing, the changes are instantly propagated to all users accessing the app, ensuring that everyone has access to the latest information. Similarly, when an employee applies for a job, the relevant data is immediately updated in Firestore, enabling employers to review applications in real time.

Firestore's flexible data model and powerful querying capabilities have enabled me to efficiently organize and retrieve data according to the application's needs. I can easily retrieve specific documents or collections of data, filter results based on various criteria, and perform complex queries to extract valuable insights from the data.

I’ve Used Firestore to store critical information such as employee data, employer data, resumes, and company details. Each of these datasets is organized within Firestore collections, allowing for efficient storage and retrieval of data.

To differentiate between employees and employers, I’ve introduced a boolean attribute named "isRecruiter" within the user documents stored in Firestore. This attribute indicates whether the user is an employee or an employer, enabling me to tailor the app's functionality accordingly.

Moreover, I’ve stored a list of job postings within Firestore, allowing employers to publish job opportunities and employees to browse available positions. Each job posting is represented as a document within a Firestore collection, containing relevant details such as job title, description, requirements, and contact information.

To associate job postings with specific companies, I’ve utilized unique identifiers (UUIDs) or other company-specific identifiers within the job documents. This enables me to efficiently retrieve job postings associated with a particular company, facilitating streamlined job search functionality within the app.

Overall, Firebase Firestore serves as the backbone of the application's data management, providing a flexible and scalable solution for storing and querying employee, employer, and job-related data. By leveraging Firestore's capabilities, I can ensure data consistency, reliability, and performance, ultimately delivering a seamless and efficient user experience.

**User:**
<img width="468" alt="Image" src="https://github.com/user-attachments/assets/ee04a4d9-b96c-4cf8-991c-0be6cd1d4886" />

**Jobs:**
<img width="468" alt="Image" src="https://github.com/user-attachments/assets/91ecf433-49fb-497d-924b-3f3fea5f430c" />

**Firebase_Storage:-** Firebase Storage serves as the central repository for managing media assets within the application, including profile pictures for employees and employers, as well as company logos. I’ve utilized Firebase Storage to securely upload, store, and serve these media files, ensuring reliable access and optimal performance for the users.

One of the key benefits of Firebase Storage is its scalability and reliability, which allows me to store large volumes of media assets without worrying about storage limitations or performance issues. This ensures that users can upload and access their profile pictures and company logos seamlessly, regardless of the size or number of files.

Additionally, Firebase Storage integrates seamlessly with other Firebase services, such as Firebase Authentication and Firestore, allowing me to associate media assets with specific user accounts or database records. This enables me to maintain consistency and integrity across the application's data and media content.

Furthermore, Firebase Storage provides robust security features to protect media assets from unauthorized access or tampering. Access to stored files can be restricted based on user authentication credentials or specific access rules defined by the application, ensuring that only authorized users can access or modify media files.

By leveraging Firebase Storage for managing media assets, I ensure a reliable and scalable solution for storing and serving profile pictures, company logos, and other media content within the application. This enhances the user experience by providing seamless access to visual assets while maintaining the integrity and security of the data.

## Libraries used

**Flutter_riverpod:** A state management library for Flutter that provides a simpler way to manage application state and dependency injection.

For this project, I adopted Flutter Riverpod as my state management solution. While there are several other alternatives available, such as GetX and Bloc, each with its strengths, I found that Riverpod best suited my needs. I have used it in authentication showing the loading to the screens and also for managing different disability features. By using Riverpod I was able to update all the pages together when I activated any disability features,

1. **Flutter Riverpod**:
    - **Choice Rationale**: Riverpod provides a balance between performance and scalability, making it an excellent fit for medium-sized projects.
    - **Community Recommendation**: Although GetX is known for its speed, it's not widely recommended by the Flutter community. On the other hand, Bloc is often preferred for larger projects due to its architecture, but for my project's scale, Riverpod emerged as the more suitable option.
    - **Flexibility**: Riverpod offers a high degree of flexibility, allowing me to efficiently manage state and dependencies within the application.

**Other Considerations**:

- - **GetX**: While GetX boasts impressive speed, it didn't align with the broader Flutter community's recommendations for the project's needs.
    - **Bloc**: Bloc is a robust solution, ideal for complex applications. However, given the size and scope of the project, it would have introduced unnecessary complexity.

**Gap**: In the project, I’ve integrated the Gap package, a utility tool designed to simplify the process of adding spacing between widgets in Flutter. While traditional methods like using sized box widgets can achieve similar results, Gap streamlines the process by providing an intuitive way to insert vertical or horizontal space between two widgets with minimal effort. This not only saves development time but also enhances code readability and promotes consistency in spacing throughout the application. By leveraging the Gap package, I ensure a more efficient and maintainable approach to managing widget spacing in the project.

**Responsive_sizer:** In the development process, I’ve integrated the Responsive_sizer package, a valuable tool designed to streamline the creation of responsive layouts in the applications. This package facilitates the utilization of percentages of screen height and width for sizing elements, making it significantly easier to ensure that the app's layout adapts seamlessly to various screen sizes and resolutions. By leveraging Responsive_sizer, I able to create responsive designs that maintain visual consistency and user experience across different devices, enhancing the overall accessibility and usability of the application. This package plays a crucial role in simplifying the implementation of responsive design principles, ultimately contributing to the creation of a more polished and user-friendly app.

**Go_router:** A declarative routing package for Flutter that uses the Router API to provide a convenient, url-based API. It provides a very easy way to navigate through the pages and it also solves so many issues that I face during the normal navigation system of flutter go router solves all of them.

**Lottie:** I have integrated the Lottie package into the app to show more animations.

**Flutter_staggered_grid_view:** In the project, I’ve integrated the Flutter_staggered_grid_view library, a versatile tool that empowers me to create staggered grid layouts with ease. This library offers robust support for displaying content in a grid format with multiple columns of varying sizes, allowing for dynamic and visually appealing arrangements of widgets. Unlike traditional grid views, which enforce a uniform size for all grid elements, Flutter_staggered_grid_view enables me to customize the size of individual grid items, thereby facilitating more creative and flexible layouts. This flexibility is particularly valuable when presenting content such as images or cards of different dimensions, as it allows me to optimize screen real estate and enhance the overall aesthetic appeal of the application. By leveraging Flutter_staggered_grid_view, I can deliver visually striking and engaging user interfaces that effectively showcase the content in a dynamic and organized manner. I have used it on different pages of the application like on the create resume screen where you can see the job functions and other options in this staggered view

**Flutter_lorem:** While testing the application I needed some dummy tests and copying the text again and again can be a time-consuming task therefore I have integrated flutter_lorem in the application, it generates lorem ipsum text.

**Readmore:** The Readmore Flutter plugin is an essential component integrated into the application, offering convenient functionality for expanding and collapsing text content. This plugin significantly enhances user experience by providing users with the ability to toggle between displaying a shorter version of the text and expanding it to reveal the full content. Moreover, Readmore goes beyond basic expand/collapse functionality by offering advanced features such as customizable styling options. With Read More, I have the flexibility to tailor the appearance of the expanded and collapsed text, ensuring consistency with the application's design language and branding. This plugin streamlines the implementation of interactive text elements, allowing me to present lengthy content in a concise and user-friendly manner. By leveraging Readmore, I create a more engaging and accessible experience for the users, empowering them to interact with text content effortlessly while maintaining visual coherence and consistency within the application. Mainly I have used this package on the job details screen where in the job description user can read the short description and if the user wants to see the whole description, the user can click on read more,

**Carousel_slider:** The Carousel_slider Flutter plugin is an indispensable tool integrated into the application, providing seamless functionality for creating captivating slideshows of images. This plugin enabled me to enhance user engagement by presenting images dynamically and interactively, allowing users to navigate through a series of pictures with ease. With Carousel_slider, I can effortlessly implement features such as automatic slide transitions, swipe gestures for navigation, and customizable slide animations, thereby enriching the visual experience for the users. Whether showcasing product images, portfolio items, or multimedia content, Carousel_slider empowers me to create compelling visual presentations that capture attention and leave a lasting impression. By leveraging this plugin, I can effectively communicate messages and showcase content in a visually appealing and engaging format, enhancing the overall user experience of the application. I have mainly used it in the home screen of the application to show the images slideshows at the top

**Cached_network_image:** The Carousel_slider Flutter plugin is an indispensable tool integrated into the application, providing seamless functionality for creating captivating slideshows of images. This plugin enables me to enhance user engagement by presenting images dynamically and interactively, allowing users to navigate through a series of pictures with ease. With Carousel_slider, I can effortlessly implement features such as automatic slide transitions, swipe gestures for navigation, and customizable slide animations, thereby enriching the visual experience for the users. Whether showcasing product images, portfolio items, or multimedia content, Carousel_slider empowers me to create compelling visual presentations that capture attention and leave a lasting impression. By leveraging this plugin, I can effectively communicate messages and showcase content in a visually appealing and engaging format, enhancing the overall user experience of the application. I have used this in almost all the pages where I have to show the networking images.

**Shimmer:** The Shimmer package is a valuable addition to the application, offering a simple yet effective solution for enhancing the user experience through shimmer’s loading effect placeholders. This package allows me to incorporate visually engaging placeholders that mimic the shimmering effect seen during data loading, providing users with immediate feedback and a sense of activity. By seamlessly integrating shimmer placeholders into the application, I create a more polished and responsive interface that keeps users engaged while content is being fetched or processed. Additionally, Shimmer offers customization options, enabling me to tailor the appearance and behavior of the placeholders to match the application's design language and branding. Overall, Shimmer significantly enhances the perceived performance of the application by improving user feedback during loading operations, ultimately contributing to a more satisfying and immersive user experience. I have used it for loading the images from the network and while loading the jobs as well,

**Modal_progress_hud_nsn**: The Modal_progress_hud_nsn package is a crucial part of the application, providing a convenient solution for displaying modal progress indicators with null safety support. This package enables me to seamlessly integrate a modal Heads Up Display (HUD) that informs users of ongoing background processes or loading operations within the application. With null safety compatibility, Modal_progress_hud_nsn ensures robust and reliable behavior, reducing the risk of runtime errors and enhancing overall stability. By incorporating this package, I can effectively communicate to users that the application is actively processing tasks while preventing unintended user interactions. Additionally, Modal_progress_hud_nsn offers customization options, allowing me to tailor the appearance and behavior of the progress indicator to align with the application's design aesthetics. Overall, Modal_progress_hud_nsn enhances the user experience by providing clear visual feedback during background processes, contributing to a more intuitive and responsive application interface. I have used it in all the authentication screens, created a resume, and created a company screen, so till the data is saved to the Firebase, I will see the loading using this package.

**Image_picker:** The Image_picker package serves as a valuable asset in the application, facilitating the seamless selection of images from the device's gallery or camera. This functionality is particularly useful for implementing image upload features, allowing users to easily choose photos or capture new ones to include in their interactions within the application. By integrating Image_picker, I streamline the process of accessing and incorporating visual content, enhancing user engagement and interaction possibilities. Whether users need to upload profile pictures, share images within social features, or attach photos to messages, this package offers a straightforward solution that ensures a smooth and intuitive experience. Furthermore, Image_picker provides robust support for both iOS and Android platforms, ensuring consistent behavior across different devices and operating systems. Overall, Image_picker significantly enriches the functionality of the application by enabling seamless image selection and upload capabilities, ultimately contributing to a more immersive and dynamic user experience. I have used it in the registration screen and created a company screen for uploading the images

**Shared_preferences:** The Shared_preferences package is a fundamental component integrated into the application, offering a convenient and platform-independent solution for managing persistent data storage. This package simplifies the process of storing and retrieving simple data across various platforms, including iOS, macOS, and Android, by wrapping platform-specific persistent storage mechanisms such as NSUserDefaults on iOS/macOS and SharedPreferences on Android. By leveraging Shared_preferences, I can efficiently store small amounts of data, such as user preferences, settings, or authentication tokens, ensuring that this information persists between application sessions. This persistent storage capability enhances user experience by maintaining continuity and personalization across different interactions with the application. Moreover, Shared_preferences provides a straightforward API for accessing stored data, making it easy to integrate into the application's logic and workflows. Overall, Shared_preferences plays a crucial role in enabling seamless data persistence across platforms, contributing to a more robust and user-friendly Flutter application. In the application, I have used it for persisting the user state so once the user is login he doesn't have to log in again and again,

**firebase_core:-** The Firebase Core package is like the starting point of the app's connection with Firebase. It helps set up Firebase services smoothly, making it easy to use features like saving data, user authentication, and messaging across different devices. With Firebase Core, I can quickly get the app connected to Firebase's powerful tools without a hassle, making it simpler to build real-time, user-friendly apps.

**firebase_auth:-** The Firebase Auth package is a key part of the app's authentication system. It lets users sign in securely using methods like email/password, phone number, or social media accounts. With Firebase Auth, I can easily manage user authentication, making it simple to build apps that keep users' accounts safe and accessible.

**firebase_firestore:**\- The Firebase Firestore package is an essential tool for the application, enabling seamless integration with Firebase's cloud-based NoSQL database. With Firestore, I can store and synchronize data in real time across multiple devices and platforms, making it easy to build collaborative and responsive applications.

**firebase_storage**:- Firebase Storage is a crucial component in the application, serving as the dedicated storage solution for assets like profile pictures and company logos. With Firebase Storage, I securely upload, download, and manage media files such as images, videos, and documents.

## Design patterns

In the application Design pattern, I’ve implemented the repository pattern to efficiently manage data operations and separate business logic from user interface concerns. The primary repository, auth_repo, serves as the central hub for handling various functionalities related to user authentication, user creation (both employees and employers), company data management, resume handling, as well as login and logout processes. By consolidating these operations within a single repository, I ensure a clear separation of concerns and maintainability in the codebase.

Within the project structure, the repository pattern enables me to organize the code into distinct layers. In the view folder, I house all user interface components such as login_page, which focuses solely on presenting the user interface to the user. This separation allows for a clean and modular design, making it easier to maintain and update the user interface independently of the underlying data logic.

In the models folder, I define all the data models used throughout the application, such as user_model. These models encapsulate the structure and behavior of the data entities, providing a clear representation of the data consumed and manipulated by the application.

By adopting the repository pattern and organizing the codebase into separate layers, I enhance code readability, scalability, and maintainability. This architectural approach fosters a modular and flexible design, making it easier to extend and evolve the application over time. Additionally, it promotes code reuse and facilitates collaboration if I have other team members working on different aspects of the application.

## Technical Challenges

**1-User Role Persistence Challenge and Solution: -**

**Description:**

One of the significant technical challenges I encountered during the development of the application was ensuring a seamless transition between user roles upon re-logging into the application. Specifically, when a user logged in as an employer and then quit the application, subsequent logins would often default the user to the employee screens instead of retaining the employer role.

**Solution:**

To address this challenge, the integration of shared preferences proved to be a great choice. By leveraging shared preferences, the application could save crucial user role information such as 'isEmployee' or 'isEmployer'. A logical mechanism was implemented to ensure mutual exclusivity between these roles, wherein if one role was set to true, the other would automatically be set to false. This ensured that upon re-launching the application, users were redirected to their respective role screens based on the saved preferences.

By implementing this solution, the application achieved enhanced user experience and eliminated the inconvenience of users being redirected to unintended screens upon re-logging in.

**2- Addressing UI Challenges with Color Inversion and Contrast ➖**

**Description-**

Another technical challenge encountered in the project was related to the simultaneous activation of color inversion and contrast settings. When both options were enabled together, it caused usability issues within the user interface.

**Solution:-** To resolve this issue, a conditional logic was implemented to ensure mutual exclusivity between color inversion and contrast settings. When one option was turned on, the other was automatically disabled, and vice versa. Specifically, if the user chose to enable color inversion, the contrast setting was automatically toggled off, and conversely, if contrast was activated, color inversion was disabled.

By implementing this solution, the application ensured a more consistent and user-friendly UI experience, mitigating any potential conflicts arising from the simultaneous activation of color inversion and contrast settings.

This adjustment contributed to improved accessibility and usability for users interacting with the application's interface.

**3- Complex Job Filtering Logic during Search:-**

**Description:-** A significant technical hurdle I encountered during the development process involved managing the complexity of job filtering logic during search operations. The multitude of conditions required for effective job filtering posed a challenge in terms of efficiency and maintainability.

**Solution**:- To address this challenge, a systematic approach was adopted, leveraging the capabilities of Firebase queries. Instead of relying on a single, cumbersome filtering process, the solution involved creating distinct Firebase queries tailored to specific filtering criteria. By breaking down the filtering conditions into separate queries, each query could efficiently handle a subset of filtering criteria, thereby optimizing the search process. This modular approach not only improved the performance of job filtering but also enhanced the maintainability of the codebase by isolating and encapsulating individual filtering functionalities. Additionally, by utilizing Firebase's real-time database capabilities, the application could dynamically adjust the query parameters based on user inputs, ensuring that search results remained relevant and up-to-date. This implementation optimized Firebase queries significantly and streamlined the job filtering process, resulting in a more responsive and user-friendly search experience for the application's users.

# Testing

## Self Testing

| Test # | Scenario | Expected Result | Actual Result | Pass / Fail |
| --- | --- | --- | --- | --- |
| 1   | Log in as an employee | Being redirected to the home screen with the name next to the profile icon | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 2   | Log in as an employer | Being redirected to the home screen with the company name next to the profile icon | As Expected | pass |
| --- | --- | --- | --- | --- |
| 3   | Creating an account as an employee | An account is created and the user can log in after logging out | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 4   | Creating an account as an employer | An account is created and the user can log in after logging out | As Expected | pass |
| --- | --- | --- | --- | --- |
| 5   | Guest navigation | Being able to navigate the app as a guest includes searching for jobs and looking threw the home page | As Expected | pass |
| --- | --- | --- | --- | --- |
| 6   | Searching | Searching threw jobs by typing the job title | As expected | pass |
| --- | --- | --- | --- | --- |
| 7   | Create job | Create a job from an employer account that appears for an employee account | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 8   | View applicant | When an employee applies for a job the employer gets a notification | As expected | Pass |
| --- | --- | --- | --- | --- |
| 9   | Apply | When an employee applies for a job the employer gets the resume | As expected | Pass |
| --- | --- | --- | --- | --- |
| 10  | My resume btn | Users can edit their resumes and the changes will save | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 11  | My company btn | User can edit their company details and it will save | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 12  | View job | When an employee clicks on a job they can see all the job details. | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 13  | Disability btn: text size | When a user uses the drag bar to increase or decrease text size it stays that way until they decide to change it | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 14  | Disability btn: color inversion | When the user clicks on color inversion the color of the widgets and other elements on the screen get inverted. | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 15  | Disability btn: color contrast | When the user clicks on color contrast the the widgets and other elements on the screen change to a darker contrast | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 16  | Disability btn: bold text | When the user clicks on the btn the text on the screen becomes bold | As Expected | Pass |
| --- | --- | --- | --- | --- |
| 18  | Screen reader | If someone does to accessibility settings on phone settings and enables a screen reader they can use it effectively | It works but it can’t read pictures | Fail |
| --- | --- | --- | --- | --- |

# Critical Review

The current functionality of my application, encompassing profile creation, job posting, application submission, and applicant viewing, lays a solid foundation. However, there are notable areas where efficiency can be significantly enhanced. Currently, the lack of direct communication between employers and employees presents a notable hurdle. Introducing a chat feature within the application would bridge this gap, facilitating real-time communication and streamlining the hiring process. Employers would gain the ability to ask questions, provide additional job details, schedule interviews, and discuss requirements directly with potential candidates, thus fostering better engagement and reducing communication delays.

Additionally, the absence of in-app job application decisions forces employers to step outside the application, creating a disjointed experience. Enabling employers to make application decisions directly within the app interface—whether accepting or rejecting applications—would streamline the hiring process, offering a cohesive user experience and allowing for prompt feedback to candidates.

Furthermore, by allowing employees to create multiple resumes within the application, the platform becomes more user-friendly and adaptable. This feature empowers job seekers to tailor their resumes to specific job roles or industries, highlighting relevant skills and experiences for each application. By addressing these aspects—implementing a chat feature, enabling in-app application decisions, and allowing for multi-resume creation—I believe my application would solidify its position as a comprehensive recruitment tool, fostering efficient communication, streamlined processes, and enhanced user customization options for both employers and job seekers.

# Project Screenshots:

## Webs 

![Image](https://github.com/user-attachments/assets/a4eb9900-34d2-433e-b529-eca71d9a99b8)

![Image](https://github.com/user-attachments/assets/150b83ea-3631-4586-92ce-379523463e6e)

## App (android):

<img width="111" alt="Image" src="https://github.com/user-attachments/assets/b278edd7-8d8a-4004-91d4-7512194d7363" />

<img width="114" alt="Image" src="https://github.com/user-attachments/assets/90a6635b-4459-4506-855c-b21a42ae2e54" />

<img width="93" alt="Image" src="https://github.com/user-attachments/assets/18a7e8b7-467d-4916-a7e7-509669f4a923" />


## App (ios): 

![Image](https://github.com/user-attachments/assets/5c13f9e5-14b8-4474-8761-36f2025ed5ff)

![Image](https://github.com/user-attachments/assets/8196b900-f78c-421f-a458-e09e2027911c)








