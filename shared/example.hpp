#pragma once

class example
{
public:
  example(const int& val);

  const int& val() const;
  void val(const int& val);
  
private:
  int m_val;
};
