

function eeg_I_MakeMouese_Click()
            import java.awt.*;
            import java.awt.event.*;
            %Create a Robot-object to do the key-pressing
            rob=Robot;
            %Commands for pressing keys:
            % If the text cursor isn't in the edit box allready, then it
            % needs to be placed there for ctrl+a to select the text.
            % Therefore, we make sure the cursor is in the edit box by
            % forcing a mouse button press:
            rob.mousePress(InputEvent.BUTTON1_MASK );
            rob.mouseRelease(InputEvent.BUTTON1_MASK );
            % CONTROL + A :
%             rob.keyPress(KeyEvent.VK_CONTROL)
%             rob.keyPress(KeyEvent.VK_A)
%             rob.keyRelease(KeyEvent.VK_A)
%             rob.keyRelease(KeyEvent.VK_CONTROL)
end
