typedef enum {
    Path,
    Start,
    Wall,
    Obstacle,
    Resource,
    End
} CellType;

typedef enum {
    Pit = 0,
    Simon,
    Avalanche,
    Trace,
    Rope,
    Catapult,
    RandomO, //Anthing after this won't be randomly generated EVER
    DragDrop
} ObstacleType;

typedef enum {
    Magic = 0,
    Notepad,
    Potion,
    Wing,
    RandomR //Anything after this won't be randomly generated EVER
} ResourceType;

typedef union {
    ObstacleType Obstacle;
    ResourceType Resource;
} SecondaryType;