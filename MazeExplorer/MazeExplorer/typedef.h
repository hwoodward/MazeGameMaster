typedef enum {
    Path,
    Start,
    Wall,
    Obstacle,
    Resource,
    End
} CellType;

typedef enum {
    DragDrop = 0,
    Simon,
    Pit,
    Avalanche,
    Trace,
    RandomO //KEEP THIS LAST
} ObstacleType;

typedef enum {
    Magic = 0,
    Notepad,
    Potion,
    RandomR //KEEP THIS LAST
} ResourceType;

typedef union {
    ObstacleType Obstacle;
    ResourceType Resource;
} SecondaryType;