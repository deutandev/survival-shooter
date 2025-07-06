# Survival Shooter 🎮

A 2D survival shooter game built with Godot Engine 4.4

## Project Organization

### Code Style References
- [GDScript style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Godot's naming conventions](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html#naming-conventions)
- [Godot project organization best practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/project_organization.html)

### Directory Structure

- **characters/**: All character-related assets
  - **player/**: Player character assets
  - **enemies/**: Enemy character assets
    - **mob/**: Basic enemy mob
    - **boss/**: Boss enemy assets
- **weapons/**: Weapon-related assets
- **....**: Other game assets


## Team Workflow

### Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/deutandev/survival-shooter.git
   ```

2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. Make your changes and commit:
   ```bash
   git add .
   git commit -m "feat(component): Description of changes"
   ```

4. Push and create a Pull Request:
   ```bash
   git push origin feature/your-feature-name
   ```

### Branch Strategy
- `main`: Production-ready code
- `feature/*`: New features or enhancements
  - `feature/player`: Player-related features
  - `feature/enemy`: Enemy-related features
- `bugfix/*`: Bug fixes (e.g., `bugfix/player-stuck-walls`)

### Branch Protection Rules
- No direct pushes to `main`
- `main` branch requires pull request reviews
