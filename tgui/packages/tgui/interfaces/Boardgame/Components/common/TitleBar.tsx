import { Box, Button } from 'tgui-core/components';

import { useBackend } from '../../../../backend';
import { BoardgameData, useActions, useStates } from '../../utils';
import { ButtonConfirm } from './ButtonConfirm';

export const TitleBar = () => {
  const { act } = useBackend<BoardgameData>();
  const {
    isFlipped,
    toggleFlip,
    helpModalOpen,
    helpModalClose,
    isHelpModalOpen,
  } = useStates();
  const { boardClear, applyGNot } = useActions(act);

  return (
    <Box className="boardgame__titlebar">
      <Button
        tooltip={isHelpModalOpen ? 'Close' : 'Help'}
        color={isHelpModalOpen ? 'orange' : 'default'}
        icon={isHelpModalOpen ? 'times' : 'question'}
        onClick={() => (isHelpModalOpen ? helpModalClose() : helpModalOpen())}
      />
      <Button
        tooltip="Flip board"
        color={isFlipped ? 'orange' : 'default'}
        icon="repeat"
        onClick={toggleFlip}
      />

      <ButtonConfirm
        tooltipContent="Clear board"
        icon="trash"
        onConfirm={() => {
          boardClear();
        }}
      />
      <ButtonConfirm
        tooltipContent="Load Chess Preset"
        icon="chess"
        onConfirm={() => {
          applyGNot(
            'r,n,b,q,k,b,n,r,p,p,p,p,p,p,p,p,32,P,P,P,P,P,P,P,P,R,N,B,Q,K,B,N,R',
          );
        }}
      />
      <ButtonConfirm
        tooltipContent="Load Draughts Preset"
        icon="ring"
        onConfirm={() => {
          applyGNot(
            '1,d,1,d,1,d,1,d,d,1,d,1,d,1,d,2,d,1,d,1,d,1,d,16,D,1,D,1,D,1,D,2,D,1,D,1,D,1,D,D,1,D,1,D,1,D',
          );
        }}
      />
    </Box>
  );
};

export default TitleBar;
