typedef enum {
    Path,
    Start,
    Wall,
    Obstacle,
    Resource,
    End
} CellType;

typedef enum {
    DragDrop,
    Simon,
    Pit,
    Avalanche
} ObstacleType;

typedef enum {
    Magic,
    Notepad,
    Potion
} ResourceType;

typedef union {
    ObstacleType Obstacle;
    ResourceType Resource;
} SecondaryType;