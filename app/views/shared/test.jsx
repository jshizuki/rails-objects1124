import React, { useState } from 'react';

// Q1. ボタンAをクリックすると、countされた回数が表示されるようにしてください。

const Component = () => {
  return (
    <div>
      <p className="click-times">クリックした回数： {count} 回</p>
      <button onClick={handleClick}>
        ボタンA * {count}
      </button>
    </div>
  );
}
