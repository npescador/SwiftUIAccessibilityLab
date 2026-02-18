# VoiceOver Audit v0.1.0

Use this template to validate manual accessibility behavior before release.

## Audit Metadata
- Date:
- Tester:
- Device:
- iOS version:
- Build:

## Global Checks
- [ ] VoiceOver navigation order is logical on each screen
- [ ] No unlabeled interactive controls
- [ ] Destructive actions include clear warning context
- [ ] Dynamic status changes are announced
- [ ] No duplicate or misleading labels

## Example 1: Login
- [ ] Email field has clear label, value, and hint
- [ ] Password field announces visibility state
- [ ] Login button communicates disabled/ready state
- [ ] Error messages are announced
- Notes:

## Example 2: Task List
- [ ] Rows are read as coherent combined elements
- [ ] Swipe alternatives are available via accessibility actions
- [ ] Search field reports current value
- [ ] Empty state is announced clearly
- Notes:

## Example 3: Task Detail
- [ ] Section headers behave as headers
- [ ] Editable fields expose current values
- [ ] Save and cancel actions provide feedback
- [ ] Due date controls have clear labels
- Notes:

## Example 4: Custom Control
- [ ] Rating is adjustable via VoiceOver gestures
- [ ] Rating value is announced correctly
- [ ] Slider value changes are announced
- [ ] Color options are labeled and selected state is clear
- Notes:

## Example 5: Settings
- [ ] Toggles announce on/off state
- [ ] Theme picker announces current selection
- [ ] Destructive action includes warning context
- [ ] Status message is announced
- Notes:

## Issues Found
| ID | Severity | Screen | Description | Repro Steps | Status |
|---|---|---|---|---|---|
| VO-001 |  |  |  |  |  |

## Sign-Off
- [ ] Release blocked until all high severity issues are resolved
- [ ] Release approved for `v0.1.0`
