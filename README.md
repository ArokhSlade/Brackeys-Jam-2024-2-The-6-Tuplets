# Workflow
- The team decides what features they need.
 - The team decides how to break the features down into tasks so that each task is manageable 
  - Each team member takes a tasks that is in her/his expertise and creates a branch with the name of the task itself, with the name being all lowercase and kebab case. Ex: "hud", "wheel-particles", "car-sounds".
   - The task gets worked on by the member inside a new (godot) scene .
    - If the member cannot make the task in a timely manner, the team must analyze what was the underlying issue, such as: unclear requirements, code complexity, other unexpected events. (WE DO NOT NEED THIS, BUT I'LL LEAVE IT TO KNOW HOW A PRO PROJECT USUALLY GOES)
     - Nobody else can submit commits to the branch, without explicit permissions from the member that started the task.
    - The task is ready and the member that is working on the task must issue a Pull Request (PR) into "development" branch.
     - The member must notify others that the PR has been created, and add one programmer as the reviewer.
      - The PR must be "Approved" by at least one programmer.
      - The PR cannot be approved by the ones who are involved in the commits.
      - If the PR has "Request changes", the member can argue that the changes are not going to work or are too complex to be made, or submit a commit with the changes and ask for review again.
    - The member must "Squash and merge" the PR to reduce the number of commits to 1, and delete the branch.
	- Branches are merged into the "development" branch, which acts as a safety net for the "main" branch.
	 - Once a new feature was merged into the "development" branch and everything works correctly, it can be merged into the "main" branch
    - The member takes another feature to work on or... the features are all done and a PR for the demo is made where all of the scene changes are merged into the main scene.
	
	