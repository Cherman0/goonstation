import { classes } from 'common/react';
import { useState } from 'react';
import {
  Box,
  Button,
  Divider,
  Dropdown,
  Image,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { capitalize } from '../common/stringUtils';
import type { ClothingBoothData } from './type';

export const ClothingBooth = () => {
  const { data } = useBackend<ClothingBoothData>();
  const categories = data.clothingBoothCategories || [];

  const [selectedCategory, selectCategory] = useState(categories[0]);
  const { items } = selectedCategory;

  return (
    <Window title={data.name} width={300} height={500}>
      <Window.Content>
        <Stack fill vertical>
          {/* Topmost section, containing the cash balance and category dropdown. */}
          <Stack.Item>
            <Section fill>
              <Stack fill align="center" justify="space-between">
                <Stack.Item bold>{`Cash: ${data.money}⪽`}</Stack.Item>
                <Stack.Item>
                  <Dropdown
                    className="clothingbooth__dropdown"
                    options={categories.map((category) => category.category)}
                    selected={selectedCategory.category}
                    onSelected={(value) =>
                      selectCategory(
                        categories[
                          categories.findIndex(
                            (category) => category.category === value,
                          )
                        ],
                      )
                    }
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          {/* Clothing booth item list */}
          <Stack.Item grow={1}>
            <Stack fill vertical>
              <Stack.Item grow={1}>
                <Section fill scrollable>
                  {items.map((item) => (
                    <ClothingBoothItem key={item.name} item={item} />
                  ))}
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          {/* Character rendering and purchase button. */}
          <Stack.Item>
            <Stack>
              <Stack.Item align="center">
                <Section fill>
                  <CharacterPreview />
                </Section>
              </Stack.Item>
              <Stack.Item grow={1}>
                <Section fill title="Purchase Info">
                  <Stack fill vertical justify="space-around">
                    <Stack.Item>
                      <PurchaseInfo />
                    </Stack.Item>
                  </Stack>
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

interface ClothingBoothItemProps {
  item;
}

const ClothingBoothItem = (props: ClothingBoothItemProps) => {
  const { act, data } = useBackend<ClothingBoothData>();
  const { item } = props;

  return (
    <>
      <Stack
        align="center"
        className={classes([
          'clothingbooth__boothitem',
          item.name === data.selectedItemName &&
            'clothingbooth__boothitem-selected',
        ])}
        onClick={() => act('select', { path: item.path })}
      >
        <Stack.Item>
          <img src={`data:image/png;base64,${item.img}`} />
        </Stack.Item>
        <Stack.Item grow={1}>
          <Box bold>{capitalize(item.name)}</Box>
        </Stack.Item>
        <Stack.Item bold>{`${item.cost}⪽`}</Stack.Item>
      </Stack>
      <Divider />
    </>
  );
};

const CharacterPreview = () => {
  const { act, data } = useBackend<ClothingBoothData>();
  return (
    <Stack vertical align="center">
      <Stack.Item textAlign>
        <Image
          height={data.previewHeight * 2 + 'px'}
          src={`data:image/png;base64,${data.previewIcon}`}
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          icon="chevron-left"
          tooltip="Clockwise"
          tooltipPosition="right"
          onClick={() => act('rotate-cw')}
        />
        <Button
          icon="chevron-right"
          tooltip="Counter-clockwise"
          tooltipPosition="right"
          onClick={() => act('rotate-ccw')}
        />
      </Stack.Item>
    </Stack>
  );
};

const PurchaseInfo = () => {
  const { act, data } = useBackend<ClothingBoothData>();
  return (
    <Stack bold vertical textAlign="center">
      {data.selectedItemName ? (
        <>
          <Stack.Item>{`Selected: ${data.selectedItemName}`}</Stack.Item>
          <Stack.Item>{`Price: ${data.selectedItemCost}⪽`}</Stack.Item>
          <Stack.Item>
            <Button
              color="green"
              disabled={data.selectedItemCost > data.money}
              onClick={() => act('purchase')}
            >
              {data.selectedItemCost <= data.money
                ? `Purchase`
                : `Insufficient Cash`}
            </Button>
          </Stack.Item>
        </>
      ) : (
        <Stack.Item>{`Please select an item.`}</Stack.Item>
      )}
    </Stack>
  );
};
