# Day 10 – Building Components That Think Together

## Tasks Completed

### 1. JobCard → Parent Communication

Updated the `JobCard` component to dispatch `viewdetails` and `apply` custom events when the user clicks the respective buttons.  
The selected Job ID is passed through the event `detail`, and the `EligibleJobs` parent receives and handles these events.  
This implements the Child → Parent communication pattern using custom events.  
The parent controls what action should happen after receiving the event.

### 2. Display Complete Job Details

Updated `EligibleJobs` to identify the selected job using the Job ID received from `JobCard`.  
When `View Details` is clicked, the complete job information is displayed instead of showing only the Job ID.  
The details include Company, Role, Package and Location.  
The selected job is maintained by the parent component.

### 3. Apply Button and Duplicate Application Message

Connected the `Apply` event from `JobCard` to the `EligibleJobs` component.  
When the Apply button is clicked for the first time, an application submitted message is displayed.  
If the same job's Apply button is clicked again, the message changes to `You have already submitted the application`.  
The applied Job IDs are tracked separately for each job.

### 4. Student Summary UI

Updated the `StudentSummary` component from a plain empty card into a dashboard-style student information section.  
Added Academic Information, Contact Information, Skills and Placement Information sections.  
The UI displays details such as Branch, CGPA, Active Backlogs, Graduation Year, Email, Phone and Placement Status.  
Salesforce Lightning components and SLDS classes were used to make the screen more structured.

### 5. Deployment

The updated LWC components were deployed from VS Code using the Salesforce CLI.  
`eligibleJobs` and `studentSummary` were deployed separately using the `sf project deploy start` command.  
The deployment result was verified using the `Status: Succeeded` message.  
The deployed components were then checked in the Salesforce Student Placement Portal.

---

# Interview Corner

## 1. How does a parent component communicate data to a child?

A parent passes information to a child through public properties using `@api`.  
For example, the parent can pass a selected Job object to a child component.

## 2. How does a child communicate an action to a parent?

A child communicates with its parent by dispatching a custom event using `CustomEvent` and `dispatchEvent()`.  
For example, `JobCard` dispatches `viewdetails` and `apply` events to `EligibleJobs`.

## 3. Why should a child not directly manipulate parent state?

Directly modifying parent state creates tight coupling between the components and makes the architecture harder to maintain.  
The child should dispatch an event and allow the parent to decide how the state should change.

## 4. What is the purpose of `@api`?

`@api` exposes public properties or methods of an LWC so that the parent can communicate with the child.  
For example, `@api job` allows the parent to pass Job information to `JobCard`.

## 5. What are custom events in LWC?

Custom events are used by child components to notify their parent that something has happened.  
They are created using `CustomEvent` and can pass information through the `detail` property.

## 6. When would you use Lightning Data Service instead of Apex?

Lightning Data Service should be preferred when standard Salesforce record operations can satisfy the requirement.  
Apex should be used when custom server-side processing or business logic is genuinely required.

## 7. Why is client-side validation not sufficient for business rules?

Client-side validation mainly provides quick feedback and improves the user experience.  
Important business rules must also be validated on the server because client-side validation can be bypassed.

## 8. What is reactive data?

Reactive data means that components depending on changing data can update when the underlying information changes.  
For example, a change in a student's CGPA may require Student Summary and Eligible Jobs to update.

## 9. Why might a component show stale information after a successful update?

The Salesforce record may have been updated successfully while the component still contains the previous data.  
The dependent component must use an appropriate refresh or reactive mechanism to display the latest information.

## 10. What is a reusable component?

A reusable component provides a meaningful UI or business capability that can be used in multiple places.  
Examples include `JobCard`, `StatusBadge`, `EmptyState` and `LoadingIndicator`.

## 11. When does component reuse become over-engineering?

Reuse becomes over-engineering when a component requires too many properties or configurations to support slightly different behaviours.  
Components should remain focused and simple instead of creating unnecessary abstraction.

## 12. How would you design communication between two sibling components?

Sibling components should normally communicate through their common parent rather than directly calling each other.  
One sibling can dispatch an event to the parent, and the parent can pass the required information to the other sibling.

---

# Think Like an Engineer

## A. One paragraph used once

A reusable component is generally unnecessary when a paragraph is used only once.  
Creating an abstraction in this case would add complexity without providing meaningful reuse.

## B. A Job Card used in three different pages

A `JobCard` is a good reusable component because the same job display behaviour is required in multiple pages.  
It reduces duplicated code and keeps the job display consistent throughout the application.

## C. A loading spinner used throughout the application

A reusable loading component can be useful when multiple screens require the same loading behaviour.  
It can provide consistent loading messages and presentation across the application.

## D. A complicated application status display used in several places

A reusable `StatusBadge` or `ApplicationStatus` component would be appropriate because the same status behaviour is required in multiple places.  
This allows one implementation to be shared by Application, Interview and Offer components.

---

# Component Architecture Review

## 1. Which components retrieve data?

Data-retrieving components are responsible for obtaining information from Salesforce through LDS, wire services or Apex.  
The architecture should avoid having multiple components independently retrieve the same information unnecessarily.

## 2. Which components display data?

Components such as `StudentSummary`, `StudentProfile`, `JobCard` and `ApplicationCard` are mainly responsible for displaying information.  
Each component should focus on presenting the data related to its specific responsibility.

## 3. Which components own state?

The component responsible for a particular workflow should normally own its related state.  
For example, `EligibleJobs` can own the selected Job state while the parent coordinates shared application state.

## 4. Which components only report events?

`JobCard` mainly reports user actions such as `viewdetails` and `apply` through custom events.  
It does not directly control the parent's state or decide the complete business workflow.

## 5. Where does business logic live?

Important business rules should remain on the server so that they cannot be bypassed by a different client.  
Client-side JavaScript can provide UI behaviour and validation, while server-side validation protects business integrity.

## 6. Are any two components retrieving the same information unnecessarily?

If the parent already has the required information, the child should normally receive it through an `@api` property.  
This avoids duplicate data retrieval and makes data ownership clearer.

## 7. Are any components becoming too large?

A component becomes too large when it starts handling many unrelated responsibilities and contains excessive state and events.  
The solution is to divide it into focused components such as `StudentSummary`, `StudentProfile`, `EligibleJobs` and `MyApplications`.

---

# Debug This – Architecture Review

## 1. A child component directly modifies a parent's property. What is wrong?

This creates unnecessary coupling because the child directly controls the parent's state.  
The child should dispatch an event and allow the parent to decide how the state should be updated.

## 2. A child component retrieves a record that the parent already has. When might that be unnecessary?

It is unnecessary when the parent already has all the information required by the child.  
The parent can pass the information using `@api`, reducing duplicate Salesforce data retrieval.

## 3. Three components each contain the same application-status display logic. What should you consider?

A reusable component such as `StatusBadge` or `ApplicationStatus` should be considered for the common behaviour.  
One implementation can then be used by multiple components instead of maintaining duplicated logic.

## 4. A form validates CGPA in JavaScript and Apex. Is that necessarily duplication?

It is not necessarily duplication because client-side validation improves user experience while server-side validation protects business integrity.  
Both validations have different purposes and can work together.

## 5. The profile save succeeds, but the Job List still displays opportunities based on the old CGPA. Where would you investigate?

First identify which Student data changed, which component owns it and which components depend on that data.  
Then check whether the appropriate wired data, LDS updates, events or refresh mechanism is updating the Job List.

## 6. A reusable component accepts 18 properties because different screens need slightly different behaviour. Has reuse gone too far?

Yes, this can indicate that the component is handling too many different responsibilities.  
The component should be simplified or divided when excessive configuration makes it difficult to understand and maintain.

---

# Sprint Retrospective

## 1. What did you learn about component communication?

I learned that parents pass information to children using public properties such as `@api`, while children communicate actions using custom events.  
This keeps communication explicit and avoids unnecessary coupling between components.

## 2. Where did you initially want to put business logic in JavaScript? Why was that a problem?

It is easy to put validation and business rules inside LWC JavaScript because it provides immediate feedback.  
However, important business rules must remain server-side because browser-side validation can be bypassed.

## 3. Which component in your project has the clearest responsibility? Why?

`JobCard` has a clear responsibility because it displays information about one job and reports user actions.  
It does not control the complete application workflow, which makes it reusable and easier to maintain.

## 4. Which component is becoming too large? What would you separate next?

`StudentPortal` can become too large if it starts handling profile, jobs, applications and other unrelated functionality.  
I would keep these responsibilities separated into focused components such as `StudentProfile`, `EligibleJobs` and `MyApplications`.

## 5. Where did you use Salesforce platform capabilities instead of writing custom code? Was that a good decision?

Salesforce Lightning base components such as `lightning-card` and `lightning-button` were used instead of recreating standard UI elements manually.  
This was a good decision because the platform provides consistent Salesforce behaviour and styling.

## 6. What happens if two components need the same changing data?

The application should define clear ownership for the shared data and provide updated information to dependent components.  
This prevents different components from maintaining separate copies that can become inconsistent.

## 7. Can you explain your component architecture to an interviewer in three minutes?

The portal is divided into focused LWCs such as `StudentSummary`, `StudentProfile`, `EligibleJobs` and `JobCard`.  
Parents pass data to children through `@api`, while children report actions through custom events and the parent coordinates the workflow.
