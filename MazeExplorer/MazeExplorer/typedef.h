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
    Simon
} ObstacleType;

typedef enum {
    Test,
    Notepad
} ResourceType;

typedef union {
    ObstacleType Obstacle;
    ResourceType Resource;
} SecondaryType;